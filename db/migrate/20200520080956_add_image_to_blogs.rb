class AddImageToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :image, :string
  end
end
