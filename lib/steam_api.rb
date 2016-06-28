# This module is responsible for retrieving information from the
# Steam API.  Before using this module, be sure to set a STEAM_API_KEY
# environment variables.
module SteamApi
  class SteamApiError < StandardError; end

  API_KEY = ENV['STEAM_API_KEY']
  BASE_URI = 'http://api.steampowered.com'.freeze

  # This method queries the Steam API and returns a JSON representation of
  # the given steam_id's entire game library.  Full game info is intentionally
  # not included in the response, as this method is destined to be used
  # for displaying a top-games list.
  #
  # Return format:
  #   { "appid": 2200, "playtime_forever": 42 }
  def all_games_for(steam_id)
    uri = "#{BASE_URI}/IPlayerService/GetOwnedGames/v0001"
    params = { steamid: steam_id }
    response = steam_get(uri, params)
    
    response['games']
  end

  # This method queries the Steam API and returns a JSON representation
  # of the given steam_id's recent game history.
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
    uri = "#{BASE_URI}/IPlayerService/GetRecentlyPlayedGames/v0001"
    params = { steamid: steam_id }
    response = steam_get(uri, params)

    response['games']
  end

  # Queries the Steam API and returns the steam_id for the specified
  # nickname.  This leverages Steam's vanity_url functionality.
  def steam_id_for(nickname)
    uri = "#{BASE_URI}/ISteamUser/ResolveVanityURL/v0001"
    params = {
      vanityurl: nickname
    }

    response = steam_get(uri, params)
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
