class CreatePosters < ActiveRecord::Migration[5.1]
  def change
    create_table :posters do |t|
      t.integer :user_id
      t.string :username
      t.string :image

      t.timestamps
    end
  end
end
