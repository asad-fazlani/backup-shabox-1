class CreateQuestSubmission < ActiveRecord::Migration[5.1]
  def change
    create_table :quest_submissions do |t|
    	t.string :option
    end
  end
end
