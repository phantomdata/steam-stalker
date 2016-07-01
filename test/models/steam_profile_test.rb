require 'test_helper'

class SteamProfileTest < ActiveSupport::TestCase
  # Test to validate that, based on vanity_name, SteamProfiles automatically
  # retrieve the steam_id when created.
  test 'should autopopulate steam_id when saving' do
    VCR.use_cassette('steam_api_requests') do
      p = SteamProfile.create(
        vanity_name: 'michael'
      )
      p.reload

      assert p.steam_id == '76561197962180080', "Steam_id was not set right."
    end
  end

  # Test to ensure that the steam_profile can list out its favorite
  # played games
  test 'should be able to get favorite games' do
    VCR.use_cassette('steam_api_requests') do
      u = users(:one)
      p = u.steam_profile
      p.update_library
      assert p.favorite_games.count == 5, 'Incorrect favorite games returned'
    end
  end


  # Test to ensure that the steam_profile can list out its recently
  # played games
  test 'should be able to get recent games' do
    VCR.use_cassette('steam_api_requests') do
      u = users(:one)
      p = u.steam_profile
      p.update_library
      assert p.recent_games.count == 13, 'Incorrect recent games returned'
    end
  end
end
