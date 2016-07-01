class CreateWatchedSteamProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :watched_steam_profiles do |t|
      t.belongs_to :user
      t.belongs_to :steam_profile

      t.string :vanity_name, required: true

      t.timestamps
    end
  end
end
