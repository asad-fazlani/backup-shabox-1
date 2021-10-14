class RemoveTypeFromQuiz < ActiveRecord::Migration[5.1]
  def change
  	remove_column :quizzes, :type
  end
end
