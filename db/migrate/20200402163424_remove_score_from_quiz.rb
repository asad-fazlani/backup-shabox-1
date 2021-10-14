class RemoveScoreFromQuiz < ActiveRecord::Migration[5.1]
  def change
  	remove_column :quizzes, :score
  end
end
