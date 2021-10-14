class AddIsAnswerToOption < ActiveRecord::Migration[5.1]
  def change
  	add_column :options, :is_answer, :boolean
  end
end
