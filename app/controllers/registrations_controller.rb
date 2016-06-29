# Override controller to add further functionality to Devise's standard
# offerings.
class RegistrationsController < Devise::RegistrationsController
  private

  # Returns the custom list of user params.
  # This method simply calls out to sign_up_params, because we actually
  # want both sets to be identical.
  def account_update_params
    sign_up_params
  end

  # Returns the custom list of user params.
  def sign_up_params
    params.require(:user).permit(:email,
                                 :current_password,
                                 :password,
                                 :password_confirmation,
                                 :vanity_name)
  end
end
