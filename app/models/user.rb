# This class represents a user within the system for authentication,
# authorization and interaction purposes.  They are currently the only type
# of acting agent within the system.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Remember, belongs_to is required:true by default
  belongs_to :steam_profile

  validates :vanity_name, presence: true
  validates :vanity_name, length: { maximum: 254 }

  before_validation :ensure_steam_profile

  private

  # This method, designed to be called on before_save, automatically
  # associates this user with a SteamProfile (creating one if it does not
  # already exist).
  def ensure_steam_profile
    return true unless vanity_name_changed?
    return false if vanity_name.blank? # This will get caught elsewhere

    self.steam_profile = SteamProfile
                         .find_or_create_by(vanity_name: vanity_name)

    # At this time, the only thing to make a SteamProfile invalid
    # is if it can't find the vanity_name. 
    unless self.steam_profile.valid?
      self.errors.add(:vanity_name, 'was not found.')
    end
  end
end
