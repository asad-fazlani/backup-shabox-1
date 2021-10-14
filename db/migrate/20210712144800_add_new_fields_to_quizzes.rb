class AddNewFieldsToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :is_free, :boolean, default: true
  end
end
