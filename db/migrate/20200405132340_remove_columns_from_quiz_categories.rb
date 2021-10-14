class RemoveColumnsFromQuizCategories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :quiz_categories, :quiz_id
  	remove_column :quiz_categories, :category_id
  end
end
