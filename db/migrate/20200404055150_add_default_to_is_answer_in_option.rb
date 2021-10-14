class AddDefaultToIsAnswerInOption < ActiveRecord::Migration[5.1]
  def change
  	change_column :options, :is_answer, :boolean, :default => false
  end
end
