# This module is responsible for retrieving information from the
# Steam API.  Before using this module, be sure to set a STEAM_API_KEY
# environment variables.
module SteamApi
  class SteamApiError < StandardError; end

  API_KEY = ENV['STEAM_API_KEY']
  BASE_URI = 'http://api.steampowered.com'.freeze

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
      message = "There was an error fetching from #{uri} with params
        #{params}.  The resulting error was #{response.body}."
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
      raise SteamApiError,
            "Invalid response returned by Steam's API as #{response}"
    end

    response_json
  end
end
