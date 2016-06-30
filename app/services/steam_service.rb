# An abstraction service for working with the ::SteamApi module within this
# application.
class SteamService
  # Leverages the SteamApi to fetch and update the passed SteamProfile's
  # library.  Will update a user's games and their playtimes
  def self.update_library_for(steam_profile)
    all_games_json = ::SteamApi.all_games_for(steam_profile.steam_id)
    recent_games_json = ::SteamApi.recent_games_for(steam_profile.steam_id)

    all_games_json.each do |game_json|

      # Ensure the game exists
      game = Game.find_or_create_by(
        appid: game_json['appid'],
      )
      
      # Check if a library entry exists...
      library_entry = LibraryEntry.where(game_id: game.id).first
      if library_entry.nil?
        library_entry = LibraryEntry.new
        library_entry.game = game
      else
        raise game_json.inspect
      end

      # Check if its been recently played...
      idx = recent_games_json.index{|g| game_json['app_id'] == g['app_id'] }
      recently_played = idx > -1

      # Update that library entry with the json...
      library_entry.playtime_in_hours = game_json['playtime_forever']
      library_entry.recently_played = recently_played
      library_entry.steam_profile_id = steam_profile.id
      library_entry.save!
    end
  end

  # Leverages the SteamApi and fetches the steam_id for the given
  # vanity_name.
  def self.steam_id_for(vanity_name)
    ::SteamApi.steam_id_for(vanity_name)
  end
end
