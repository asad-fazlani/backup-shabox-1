class DropQuestOpt < ActiveRecord::Migration[5.1]
  def change
  	drop_table :quest_opts
  end
end
