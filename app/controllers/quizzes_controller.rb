class QuizzesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :require_admin, except: [:index, :show, :update_payment, :result ]
  before_action :set_quiz, only: [:show, :edit, :update]
  before_action :check_paid, only: [:show]
  def index
    if current_user.present? and current_user.admin?
      @quizzes = Quiz.paginate(page: params[:page], per_page: 6)
    else
      @quizzes = Quiz.where(id: Question.select("quiz_id").group(:quiz_id).having("count(id)>1")).paginate(page: params[:page], per_page: 6) #Only send quizzes with more than 1 question
    end
     @submissions = Submission.all   
  end
  def new
    @quiz = Quiz.new
  end
  
  def update_payment
    @quiz = Quiz.find_by_id(params[:product_id])
    payment = current_user.payment_histories.new(quiz_id: @quiz.id, payment_id: params[:razorpay_payment_id], status: 1)
    if payment.save
      flash[:alert] = "payment successfully made."
      redirect_to quiz_path(@quiz)
    else
      redirect_to quizzes_path
    end
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      flash[:success] = "Quiz was successfully created"
      redirect_to quiz_path(@quiz)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @quiz.update(quiz_params)
      flash[:success] = "Quiz was successfully updated"
      redirect_to quiz_path(@quiz)
    else
      render 'edit'
    end

  end

  def show
    @questions = Question.where(quiz_id: @quiz.id) #Questions of the quiz
    @question_all = @questions.paginate(page: params[:page], per_page: 5) #questions paginated
    @total_score = @questions.sum(:score) #Total score of all the questions in the quiz
    @option = Option.new
    @option_all = Option.where(question_id: @questions) #All options of the quiz
    quest_count=0 #Count of all the valid questions in the quiz
    @questions.each do |each_question| 
      found = false #Presence of answer
      count=0 #Number of options
        @option_all.each do |each_option| 
        if each_option.question_id == each_question.id 
          count +=1 
          if each_option.is_answer == true 
            found = true 
          end 
        end 
      end 
       if found==true && count>=2 #Increment valid question count if number of options is more than 1 and has an answer
         quest_count+=1 
       end 
    end 
    if !current_user.admin? && (@questions.length()<2 || quest_count < 2)
      redirect_to quizzes_path
    end
    @submission = Submission.new 
    @submission.quest_submissions.build #Nested form for quest_submissions

    @question = Question.new
    if params.has_key?(:question_messages) #Check if error messages are passed and display them
      @question_messages = params[:question_messages] 
    else
      @question_messages = ""
    end
    if params.has_key?(:option_messages)
      @option_messages = params[:option_messages] 
    else
      @option_messages = ""
    end  
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    flash[:danger] = "Quiz was successfully deleted"
    redirect_to quizzes_path
  end

  def editQuestion
    @each_question = Question.find(params[:each_question].to_i)
    if params.has_key?(:question_messages) #Check if error messages are passed and display them
      @question_messages = params[:question_messages] 
    else
      @question_messages = ""
    end
  end

  def editOption
    @each_option = Option.find(params[:each_option].to_i) 
    @each_question = Question.find(@each_option.question_id) #Question of that option
    if params.has_key?(:option_messages) #Check if error messages are passed and display them
      @option_messages = params[:option_messages] 
    else
      @option_messages = ""
    end
  end

  private

  def quiz_params

    params.require(:quiz).permit(:name, category_ids: [])

  end
  def check_paid
    unless @quiz.is_free
      transaction_present = current_user.payment_histories.find_by(quiz_id: @quiz.id)
      unless transaction_present.present?
        flash[:alert] = "Pay the quiz fees first."
        redirect_to quizzes_path
      end
    end
  end

  def result
  end
  def set_quiz
    @quiz = Quiz.friendly.find(params[:id])
  end
end
