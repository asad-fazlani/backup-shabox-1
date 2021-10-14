class CreatePaymentRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
