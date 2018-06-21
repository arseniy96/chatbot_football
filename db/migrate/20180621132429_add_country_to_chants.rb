class AddCountryToChants < ActiveRecord::Migration[5.1]
  def change
    add_column :chants, :country1, :string
    add_column :chants, :country2, :string
  end
end
