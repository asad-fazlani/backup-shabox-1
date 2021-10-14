class AddSubscribeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subscribe, :boolean, default: true
    add_column :blogs, :email_sent, :boolean, default: false
  end
end
