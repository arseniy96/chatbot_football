class AddGroupsAndPostsTousers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :groups, :text
    add_column :users, :posts, :text
  end
end
