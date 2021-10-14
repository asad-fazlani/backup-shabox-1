class AddStatusToBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :status, :string, null: 'false' ,defauul: 'draft'
  end
end
