class CreatePaymentHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quiz, null: false, foreign_key: true
      t.string :payment_id
      t.integer :status

      t.timestamps
    end
  end
end
