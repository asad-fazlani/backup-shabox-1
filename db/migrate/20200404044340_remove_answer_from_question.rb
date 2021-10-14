class RemoveAnswerFromQuestion < ActiveRecord::Migration[5.1]
  def change
  	remove_column :questions, :answer
  end
end
