class RemoveBlogFromComments < ActiveRecord::Migration[6.1]
    def self.down
      remove_column :comments, :blog_id
  end
end