class RemoveQuestionReferenceFromQuestSubmission < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :quest_submissions, :questions
  end
end
