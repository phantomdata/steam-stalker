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

  def ensure_steam_profile
    return true if self.steam_profile
    existing_profile = SteamProfile.for_vanity_name(vanity_name).first
    if existing_profile
      self.steam_profile = existing_profile
      return
    end

    self.steam_profile = SteamProfile.create(vanity_name: vanity_name)
  end
end
