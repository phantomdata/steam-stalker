include SteamApi

# Please note, Robin Walker is used throughout these tests.  This is the user
# utilized by the Steam API docs to demonstrate functionality.
# TODO: Add anti-tests
# TODO: Investigate if I want to include the un-maintained
#       VCR gem to prevent this from breaking in the future.

class SteamApiTest < ActiveSupport::TestCase
  TEST_USERNAME = "robinwalker".freeze
  TEST_STEAM_ID = "76561197960435530".freeze

  # The base happy path for getting all games
  test 'can get all games' do
    all_games = ::SteamApi::all_games_for(TEST_STEAM_ID)
    assert all_games.count > 0, "No games were returned"
  end

  # The base happy path for getting a player's recent games
  test 'can get recent games' do
    recent_games = ::SteamApi::recent_games_for(TEST_STEAM_ID)
    assert recent_games.count > 0, "No recent games were displayed."
  end

  # The base happy path for getting a steam id
  test 'can get valid steam_id' do
    steam_id = ::SteamApi::steam_id_for(TEST_USERNAME)
    assert steam_id == TEST_STEAM_ID,
      "Steam ID was resolved as #{steam_id} instead of #{TEST_STEAM_ID}"
  end

end
