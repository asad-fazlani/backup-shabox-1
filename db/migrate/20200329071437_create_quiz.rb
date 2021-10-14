class CreateQuiz < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
    	t.integer :score
    	t.text :type
    	t.timestamps
    end
  end
end
