class CreateBlogSuggestions < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_suggestions do |t|
      t.string :title
      t.integer :status , :default => 1
      t.text :description

      t.timestamps
    end
  end
end
