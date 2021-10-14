class AddNameToQuiz < ActiveRecord::Migration[5.1]
  def change
  	add_column :quizzes, :name, :string 
  end
end
