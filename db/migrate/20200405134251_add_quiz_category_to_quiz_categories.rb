class AddQuizCategoryToQuizCategories < ActiveRecord::Migration[5.1]
  def change
  	add_column :quiz_categories, :quiz_id, :integer
  	add_column :quiz_categories, :category_id, :integer
  end
end
