class CreateOption < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
    	t.string :opt
    end
  end
end
