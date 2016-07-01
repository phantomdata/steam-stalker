# This module is responsible for retrieving information from the
# Steam API.  Before using this module, be sure to set a STEAM_API_KEY
# environment variables.
#
# NOTE: I recognize that this could be factored into a gem.  This project's
# purpose, however, is not to spawn something to be later maintained - but
# instead a useful project straight away.
module SteamApi
  class SteamApiError < StandardError; end
  class << self
    API_KEY = ENV['STEAM_API_KEY']
    BASE_URI = 'http://api.steampowered.com'.freeze

    ALL_GAMES_API_URL="#{BASE_URI}/IPlayerService/GetOwnedGames/v0001".freeze
    RECENT_GAMES_API_URL="#{BASE_URI}/IPlayerService/GetRecentlyPlayedGames/v0001".freeze
    STEAM_ID_API_URL="#{BASE_URI}/ISteamUser/ResolveVanityURL/v0001".freeze

    # This method queries the Steam API and returns a JSON representation of
    # the given steam_id's entire game library.  Full game info is intentionally
    # not included in the response, as this method is destined to be used
    # for displaying a top-games list.
    #
    # Return format:
    #   { "appid": 2200, "playtime_forever": 42 }
    def all_games_for(steam_id)
      params = { steamid: steam_id, include_appinfo: 1 }
      response = steam_get(ALL_GAMES_API_URL, params)

      response['games']
    end

    # This method queries the Steam API and returns a JSON representation
    # of the given steam_id's recent game history.
    #
    # NOTE: This method returns AppInfo for all games, despite the fact that
    # we may not need it.  Unfortunately, Steam currently offers no way
    # to retrieve the icon url; so we have to pull this down here instead
    # of letting it be loaded on a need-to-load basis.
    #
    # Return format:
    #   {
    #     "appid": 220,
    #     "name": "The Witcher 3",
    #     "playtime_2weeks": 1290,
    #     "playtime_forever": 3504,
    #     "img_icon_url": "87118494c65a92e1ac4c9734ce91950c1d6fe9a5",
    #     "img_logo_url": "2f22c2e5528b78662988dfcb0fc9aad372f01686"
    #   }
    def recent_games_for(steam_id)
      params = { steamid: steam_id }
      response = steam_get(RECENT_GAMES_API_URL, params)

      response['games']
    end

    # Queries the Steam API and returns the steam_id for the specified
    # nickname.  This leverages Steam's vanity_url functionality.
    def steam_id_for(nickname)
      params = { vanityurl: nickname }
      response = steam_get(STEAM_ID_API_URL, params)
      response['steamid']
    end

    private

    # This method issues a GET request against the specified uri with its
    # params.  If an invalid (non-200) response is returned, a nicely formatted
    # error is thrown.
    #
    # If a successful request is made, this method returns a JSON object taken
    # from the root 'response' object provided in all valid SteamAPI requests.
    def steam_get(uri, params)
      params[:key] = API_KEY
      response = HTTParty.get(uri, query: params)

      unless response.code == 200
        message = I18n.translate('.errors.steam_api.http_error',
                                 uri: uri,
                                 params: params,
                                 response_body: response.body)
        raise SteamApiError, message
      end

      parse_response_json(response.body)
    end

    # This method takes a standard SteamApi response and returns a JSON object
    # represented from the root 'response' object provided in all valid SteamAPI
    # requests
    def parse_response_json(response_body)
      response_json = JSON.parse(response_body)['response']

      unless response_json
        message = I18n.translate('.errors.steam_api.json_error',
                                 response_body: response_body)
        raise SteamApiError, message
      end

      response_json
    end
  end
end
