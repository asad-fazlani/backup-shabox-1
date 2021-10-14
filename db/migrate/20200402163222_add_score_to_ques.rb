class AddScoreToQues < ActiveRecord::Migration[5.1]
  def change
  	add_column :questions, :score, :integer 
  end
end
