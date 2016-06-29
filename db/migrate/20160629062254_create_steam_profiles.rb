class CreateSteamProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :steam_profiles do |t|
      t.datetime :info_last_refreshed_at
      t.string :steam_id, required: true
      t.string :vanity_name, required: true
    end

    add_index :steam_profiles, :vanity_name
  end
end
