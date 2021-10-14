class AddQuizAndQuestToQuizQuests < ActiveRecord::Migration[5.1]
  def change
  	add_reference :quiz_quests, :quiz, foreign_key: true
  	add_reference :quiz_quests, :question, foreign_key: true
  end
end
