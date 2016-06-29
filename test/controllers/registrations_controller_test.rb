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

  # Test that the custom vanity name property can be set
  test 'should set a vanity name' do
    patch '/users', params: {
      user: {
        email: @user.email,
        current_password: 'password',
        vanity_name: 'Test'
      }
    }
    @user.reload

    assert_response :redirect
    assert @user.vanity_name == 'Test', 'Vanity name was not set'
  end

  # Test that a vanity name is required.
  # There is weird error catching to detect, because edit page rendering
  # does not work in Rails 5 with the current version of Devise+Minitest.
  test 'should require a vanity name' do
    begin
      patch '/users', params: {
        user: {
          email: @user.email,
          password: 'password',
          vanity_name: ""
        }
      }
      assert false, "Nil vanity name was accepted"
    rescue ActionView::Template::Error => ex
    end
  end

end
