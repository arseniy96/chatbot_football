class AddInviteCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :invite_code, :string
  end
end
