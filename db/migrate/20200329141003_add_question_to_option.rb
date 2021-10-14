class AddQuestionToOption < ActiveRecord::Migration[5.1]
  def change
  	add_reference :options, :question, foreign_key: true
  end
end
