class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :appid, required: true
      t.string :icon_url
      t.string :name

      t.timestamps
    end
  end
end
