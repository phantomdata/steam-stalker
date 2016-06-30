require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Test to validate that when a user is created, it gets a steam_profile
  # also created and automatically associated.
  test 'should autocreate a new steam profile' do
    VCR.use_cassette('steam_api_requests') do
      u = User.create(
        email: 'jane@example.com',
        password: 'password',
        vanity_name: 'michael'
      )

      assert u.steam_profile, 'No SteamProfile was automatically created'
      assert u.steam_profile.vanity_name == u.vanity_name, 'SteamProfile the wrong vanity_name for the user'
    end
  end

  test 'should handle if the child SteamProfile couldnt be created' do
    VCR.use_cassette('steam_api_requests', record: :new_episodes) do
      u = User.create(
        email: 'null@example.com',
        password: 'password',
        vanity_name: 'probably-never-exist-23srtdrtTT')

      assert u.errors.keys.include?(:vanity_name), 
        'Invalid vanity name allowed'
    end
  end
end
