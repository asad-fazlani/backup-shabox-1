class AddQuestionAndSubmissionToQuestSubmission < ActiveRecord::Migration[5.1]
  def change
  	add_reference :quest_submissions, :question, foreign_key: true
  	add_reference :quest_submissions, :submission, foreign_key: true
  end
end
