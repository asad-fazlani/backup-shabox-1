class AddQuestAndOptToQuestOpt < ActiveRecord::Migration[5.1]
  def change
  	add_reference :quest_opts, :question, foreign_key: true
  	add_reference :quest_opts, :option, foreign_key: true
  end
end
