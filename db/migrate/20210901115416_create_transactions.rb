class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :competition_id
      t.integer :blog_id
      t.integer :user_id
      t.integer :favoritor_user

      t.timestamps
    end
  end
end
