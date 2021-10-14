class CreateMailServices < ActiveRecord::Migration[6.1]
  def change
    create_table :mail_services do |t|
      t.string :title
      t.string :email
      t.string :full_name
      t.text :body

      t.timestamps
    end
  end
end
