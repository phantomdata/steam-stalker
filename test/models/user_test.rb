require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should autocreate a new steam profile' do
    u = User.create(
      email: 'jane@example.com',
      password: 'password',
      vanity_name: 'michael'
    )
    assert u.steam_profile, 'No SteamProfile was automatically created'
    assert u.steam_profile.vanity_name == u.vanity_name, 'SteamProfile the wrong vanity_name for the user'
  end
end
