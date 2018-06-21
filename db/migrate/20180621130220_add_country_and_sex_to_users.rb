class AddCountryAndSexToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :country, :string
    add_column :users, :sex, :string
  end
end
