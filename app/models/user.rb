# This class represents a user within the system for authentication,
# authorization and interaction purposes.  They are currently the only type
# of acting agent within the system.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :steam_profile, required: false

  validates :vanity_name, presence: true
  validates :vanity_name, length: { maximum: 254 }

  before_save :ensure_steam_profile

  private

  # This method, designed to be called on before_save, automatically
  # associates this user with a SteamProfile (creating one if it does not
  # already exist).
  def ensure_steam_profile
    return true if steam_profile
    self.steam_profile = SteamProfile
                         .find_or_create_by(vanity_name: vanity_name)
  end
end
