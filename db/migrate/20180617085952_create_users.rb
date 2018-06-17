class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :avatar
      t.integer :vk_id

      t.timestamps
    end
  end
end
