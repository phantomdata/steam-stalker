# Please note, Robin Walker is used throughout these tests.  This is the user
# utilized by the Steam API docs to demonstrate functionality.

class SteamServiceTest < ActiveSupport::TestCase
  TEST_USERNAME = "robinwalker".freeze
  TEST_STEAM_ID = "76561197960435530".freeze

  # The base happy path for retrieving all games
  test 'should retrieve the users full steam library' do
    VCR.use_cassette('steam_api_requests') do
      user = users(:one)
      profile = user
      SteamService.update_library_for(profile.steam_profile)
      
      user.reload
      assert user.steam_profile.library_entries.count == 590,
        "Not enough library entries read."
    end
  end

  # Ensuring that recently played games show up as such
  #
  # Yes, I know the query is obtuse.  This particular data will never be
  # needed in the actual application; so I choose instead to muddy up this
  # one test a bit.
  test 'should setup recently played games' do
    VCR.use_cassette('steam_api_requests') do
      user = users(:one)
      profile = user
      SteamService.update_library_for(profile.steam_profile)
      
      user.reload
      game = Game.where(appid: 400760).first
      assert user
        .steam_profile
        .library_entries
        .recent
        .where(game_id: game.id)
        .count > 0,
          "400760 wasn't found amongst the recent games."
    end
  end


  # The base happy path for retrieving a steam_id
  test 'should retrieve steam_id from vanity_name' do
    VCR.use_cassette('steam_api_requests') do
      steam_id = SteamService.steam_id_for(TEST_USERNAME)
      assert steam_id == TEST_STEAM_ID, "Invalid steam id returned"
    end
  end
end
