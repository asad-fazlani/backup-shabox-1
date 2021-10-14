class CreateCompetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :competitions do |t|
      t.string :competition_type
      t.integer :count
      t.integer :per_price
      t.integer :limits
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status

      t.timestamps
    end
  end
end
