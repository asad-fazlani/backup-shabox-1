class DropQuizQuest < ActiveRecord::Migration[5.1]
  def change
  	drop_table :quiz_quests
  end
end
