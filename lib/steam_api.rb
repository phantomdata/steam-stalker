# This module is responsible for retrieving information from the
# Steam API.
module SteamApi
  class SteamApiError < StandardError; end

  API_KEY = ENV['STEAM_API_KEY']
  BASE_URI = 'http://api.steampowered.com'.freeze

  # Queries the Steam API and returns the steam_id for the specified
  # nickname.
  def steam_id_for(nickname)
    uri = "#{BASE_URI}/ISteamUser/ResolveVanityURL/v0001"
    params = {
      key: API_KEY,
      vanityurl: nickname
    }
    response = steam_get uri, params
    response_json = JSON.parse(response)

    steamid = response_json['response'] && response_json['response']['steamid']

    unless steamid
      raise SteamApiError, "Invalid response returned by Steam's API as #{response}"
    end

    steamid
  end

private

  # This method issues a GET request against the specified uri with its
  # params.  If an invalid (non-200) response is returned, a nicely formatted
  # error is thrown.
  def steam_get uri, params
    response = HTTParty.get(uri, {query: params})
    unless response.code == 200
      message = "There was an error fetching from #{uri} with params
        #{params.to_s}.  The resulting error was #{response.body}."
      raise SteamApiError, message
    end

    return response.body
  end

end
