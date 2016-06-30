require 'test_helper'

class SteamProfile < ActiveSupport::TestCase
  # Test to validate that, based on vanity_name, SteamProfiles automatically
  # retrieve the steam_id when created.
  test 'should autopopulate steam_id when saving' do
    VCR.use_cassette('get_steam_id_michael') do
      p = SteamProfile.create(
        vanity_name: 'michael'
      )
      p.reload

      assert p.steam_id == '76561197962180080', "Steam_id was not set right."
    end
  end
end
