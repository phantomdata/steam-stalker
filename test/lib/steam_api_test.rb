include SteamApi

# Please note, Robin Walker is used throughout these tests.  This is the user
# utilized by the Steam API docs to demonstrate functionality.
class SteamApiTest < ActiveSupport::TestCase
  TEST_USERNAME = "robinwalker"
  TEST_STEAM_ID = "76561197960435530"

  # The base happy path for getting a steam id
  test 'can get valid steam_id' do
    steam_id = ::SteamApi::steam_id_for(TEST_USERNAME)
    assert steam_id == TEST_STEAM_ID,
      "Steam ID was resolved as #{steam_id} instead of #{TEST_STEAM_ID}"
  end

  # TODO: Add anti-tests
end
