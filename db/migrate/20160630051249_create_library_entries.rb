class CreateLibraryEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :library_entries do |t|
      t.belongs_to :game, index: true
      t.belongs_to :steam_profile, index: true

      t.datetime :info_last_refreshed_at, required: true
      t.integer :playtime_in_hours
      t.boolean :recently_played, required: true

      t.timestamps
    end
  end
end
