class AddSteamProfileIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :steam_profile_id, :integer, required: true
  end
end
