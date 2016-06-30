class DropSteamIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :steam_id
  end
end
