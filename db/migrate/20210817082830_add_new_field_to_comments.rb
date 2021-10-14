class AddNewFieldToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end
