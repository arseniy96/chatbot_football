class CreateChants < ActiveRecord::Migration[5.1]
  def change
    create_table :chants do |t|
      t.text :text
      t.string :image
      t.belongs_to :user

      t.timestamps
    end
  end
end
