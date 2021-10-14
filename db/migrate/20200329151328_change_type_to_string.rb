class ChangeTypeToString < ActiveRecord::Migration[5.1]
  def change
  	change_column :quizzes, :type, :string
  end
end
