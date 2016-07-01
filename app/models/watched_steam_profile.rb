# This class defines what profiles a given user is watching
class WatchedSteamProfile < ApplicationRecord
  belongs_to :steam_profile
  belongs_to :user

  validates :vanity_name, presence: true
  validate :steam_profile_must_be_valid

  before_validation :ensure_steam_profile

  private

  # Designed to be called before_validation, this method ensures that the
  # WatchedSteamProfile has an actual steam_profile associated with it.
  def ensure_steam_profile
    return if vanity_name.blank?
    self.steam_profile = SteamProfile.find_or_create_by(
      vanity_name: vanity_name
    )
  end

  # Ensures the validity of the steam profile.  There's literally only
  # one thing that can be set right now, which is the vanity name.  This
  # may need to be expanded in the future.
  def steam_profile_must_be_valid
    return if steam_profile.nil? # This will get caught elsewhere

    unless steam_profile.valid?
      errors.add(:steam_profile, 'Invalid vanity name.')
    end
  end
end
