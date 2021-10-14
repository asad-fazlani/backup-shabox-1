class OptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)
    @question = Question.find(params[:option][:question_id].to_i) #Question of that option
    @option_all = Option.where(question_id: @question.id) #Options of the question
    can_save=true
    @option_all.each do |each_option|
      if each_option.opt_name==@option.opt_name #Check if another option with the same name exists for the question
        can_save=false 
      end
      if each_option.is_answer==true #Check if there is an answer
        @answer=each_option
      end
    end


    if can_save==false
      flash[:danger] = "Option #{@each_option.opt_name} already exists"
      redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id
    else
      if @option.save 
        if @option.is_answer==true && @answer.present? #Make the old answer as false
          @answer.is_answer=false
          @answer.save
        end
        flash[:success] = "Option was successfully created"
        redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id
      else
        redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id, option_messages: @option.errors.full_messages
      end
    end
  end

  def edit
  end

  def update
    @each_option = Option.find(params[:id]) #option passed as parameter
    @question = Question.find(@each_option.question_id) #Question of that option
    @option_all = Option.where(question_id: @question.id) #All options of that question
    @option_all = Option.where(question_id: @question.id) #All options of that question
    can_save=true
    @same_option = @option_all.where(opt_name: @each_option.opt_name)#All options of the question with the same name
    @same_option.each do |opt|
      if opt.id!=@each_option.id
        can_save=false #Only set false if option other than the option passed has the same name
      end
    end

    @option_all.each do |each_opt| #Check if answer exists for the question
      if each_opt.is_answer==true
        @answer=each_opt #Save the option as answer
      end
    end

    if can_save==false 
      same_opt_name=params[:option][:opt_name]
      flash[:danger] = "Option #{same_opt_name} already exists"
      redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id
    else
      if @each_option.update(option_params)
        if @each_option.is_answer==true && @answer.present? #Make the old answer false if the option passed is an answer
          @answer.is_answer=false 
          @answer.save
        end
        flash[:success] = "Option was successfully updated"
        redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id
      else
        redirect_to controller: 'quizzes', action: 'editOption', each_option: @each_option, option_messages: @each_option.errors.full_messages #Also send the error messages
      end
    end
  end

  def show
  end

  def destroy
    @option = Option.find(params[:id])
    @question = Question.find(@option.question_id)
    @option.destroy
    flash[:danger] = "Option was successfully deleted"
    redirect_to controller: 'quizzes', action: 'show', id: @question.quiz_id
  end

  private

  def option_params

    params.require(:option).permit(:opt_name, :is_answer, :question_id)

  end
end
