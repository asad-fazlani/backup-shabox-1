class AddCompetitionIdToBlog < ActiveRecord::Migration[6.1]
  def change
    add_column :blogs, :competition_id, :integer
  end
end
