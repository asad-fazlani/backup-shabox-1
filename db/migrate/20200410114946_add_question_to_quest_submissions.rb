class AddQuestionToQuestSubmissions < ActiveRecord::Migration[5.1]
  def change
  	add_column :quest_submissions, :question_id, :integer 
  end
end
