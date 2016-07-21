# An abstraction service for working with the ::SteamApi module within this
# application.

require 'steam_api'

class SteamService
  class << self
    # Leverages the SteamApi to fetch and update the passed SteamProfile's
    # library.  Will update a user's games and their playtimes
    def update_library_for(steam_profile)
      return if steam_profile.steam_id.nil?
      all_games_json = ::SteamApi.all_games_for(steam_profile.steam_id)
      recent_games_json = ::SteamApi.recent_games_for(steam_profile.steam_id)

      all_games_json.each do |game_json|
        game = find_or_create_game_from_json!(game_json)
        recent_game = recent_games_json&.detect { |g| g['appid'] == game.appid }
        playtime = game_json['playtime_forever']

        update_game_from_recent_game_json!(game, recent_game)
        upsert_library_entry(game, playtime, recent_game, steam_profile)
      end
    end

    # Leverages the SteamApi and fetches the steam_id for the given
    # vanity_name.
    def steam_id_for(vanity_name)
      ::SteamApi.steam_id_for(vanity_name)
    end

    private

    # Given the passed in parameters, this method upserts the specified library
    # entry.  Ensuring that it is updated if it exists, or created if not.
    def upsert_library_entry(game, playtime, recent_game, steam_profile)
      library_entry = LibraryEntry.find_or_initialize_by(game_id: game.id)
      library_entry.playtime_in_hours = playtime / 60
      library_entry.recently_played = !recent_game.nil?
      library_entry.steam_profile_id = steam_profile.id
      library_entry.save!
    end

    def find_or_create_game_from_json!(game_json)
      game = Game.find_or_create_by(appid: game_json['appid'])
      game.update_attributes(
        name: game_json['name'],
        icon_url: game_json['img_icon_url']
      )
      game
    end

    # If needed, this method updates the passed in Game object with the data
    # found in the passed recent_games_json and persists those changes to the
    # database.
    #
    # NOTE: Why icon and not logo?  Logos are inconsistently available
    # in the API.
    def update_game_from_recent_game_json!(game, recent_game_json)
      return if recent_game_json.nil?
      game.update_attributes(
        name: recent_game_json['name'],
        icon_url: recent_game_json['img_icon_url']
      )
    end
  end
end
