class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  # Devise is not ready for Rails5 and the change to IntegrationTest yet;
  # so we have to manually use Warden's login functionality at this time.
  # See: https://github.com/plataformatec/devise/issues/3913
  setup do
    @user = users(:one)
    Warden.test_mode!
    login_as(@user, scope: :user)
  end

  teardown do
    Warden.test_reset!
  end

  test 'can set a vanity name' do
    post '/users', params: {
      user: {
        email: @user.email,
        vanity_name: 'Test'
      }
    }
    @user.reload
    assert_response :redirect
    assert @user.vanity_name = 'Test'
  end

  test 'must set a vanity name' do
    post '/users', params: {
      user: {
        email: @user.email,
        vanity_name: nil
      }
    }
  end
end
