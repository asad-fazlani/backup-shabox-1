class AddMobileToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :country_code, :string
    add_column :users, :phone_number, :string
  end
end
