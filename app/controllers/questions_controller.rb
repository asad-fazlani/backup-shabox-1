class QuestionsController < ApplicationController

  before_action :authenticate_user!
  before_action :require_admin

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question was successfully created"
      redirect_to controller: 'quizzes', action: 'show', id: params[:question][:quiz_id].to_i
    else
      @question.errors.full_messages
      redirect_to controller: 'quizzes', action: 'show', id: params[:question][:quiz_id].to_i, question_messages: @question.errors.full_messages
    end
  end

  def edit
  end

  def update
    @each_question = Question.find(params[:id]) 

    if @each_question.update(question_params)
      flash[:success] = "Question was successfully updated"
      redirect_to controller: 'quizzes', action: 'show', id: @each_question.quiz_id
    else
      redirect_to controller: 'quizzes', action: 'editQuestion', each_question: @each_question, question_messages: @each_question.errors.full_messages
    end
  end

  def show
    @comment = @blog.comments.build
  end

  def destroy
    @question = Question.find(params[:id])
    @quizID = @question.quiz_id
    @question.destroy
    flash[:danger] = "Question was successfully deleted"
    redirect_to controller: 'quizzes', action: 'show', id: @quizID
  end

  private

  def question_params

    params.require(:question).permit(:questions, :score, :quiz_id, options_attributes: [:id, :opt_name, :is_answer, :question_id, :_destroy])

  end
end
