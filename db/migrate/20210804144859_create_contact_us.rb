class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.string :email
      t.string :name
      t.string :subject
      t.text :body
      t.string :mobile_number

      t.timestamps
    end
  end
end
