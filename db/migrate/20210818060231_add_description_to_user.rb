class AddDescriptionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :description, :text
    add_column :users, :profession, :string
    add_column :users, :faceboook_link, :string
    add_column :users, :instagram_link, :string
    add_column :users, :github_link, :string
    add_column :users, :linkedin_link, :string
  end
end
