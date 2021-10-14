class SubmissionsController < ApplicationController

	before_action :authenticate_user!

	def new

	end

	def create
		@submission = Submission.new(submission_params)
		old_submission = Submission.where(user_id: @submission.user_id, quiz_id: @submission.quiz_id) #All old submission by the same user and for the same quiz
		old_submission.each do |old_sub|
			old_sub.destroy
		end
	    if @submission.save
	        flash[:success] = "Quiz was submitted succesfully"
	        total_score=0
	        option_all = Option.where(question_id: Question.where(quiz_id: @submission.quiz_id)) #All options of the quiz
	        #Either collect all the options of a quiz or collect options for each question inside the next loop
	        question_subs = QuestSubmission.where(submission_id: @submission.id) 
	        question_subs.each do |q_sub|
	        	question=Question.find(q_sub.question_id) #Find the question for each submission
	        	answer=nil
	        	option_all.each do |each_option|
	        		if each_option.question_id == question.id
	        			if each_option.is_answer == true 
	        				answer = each_option.opt_name #Find the answer for each question
	        			end
	        		end
	        	end
	        	if q_sub.option==answer #If the option submitted is the answer, add the score
	        		total_score+=question.score
	        	end
	        end
	        @submission.score=total_score #Save the score to the submission
	        @submission.save
	        redirect_to controller: 'quizzes', action: 'result'
	    else
	    	flash[:danger] = "Something went wrong"
			redirect_to controller: 'quizzes', action: 'show', id: params[:quiz_id].to_i
	    end
	end


	private

    def submission_params

		params.require(:submission).permit(:user_id, :quiz_id, quest_submissions_attributes: [:question_id, :option])

	end
end