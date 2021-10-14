class RemoveQuestionFromQuestSubmissions < ActiveRecord::Migration[5.1]
  def change
  	remove_column :quest_submissions, :question_id
  end
end
