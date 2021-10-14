class ChangeOptToOptNameInOption < ActiveRecord::Migration[5.1]
  def change
  	rename_column :options, :opt, :opt_name
  end
end
