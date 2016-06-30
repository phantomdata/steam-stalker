# This class represents a given Steam user's basic metadata.
# TODO: Add uniqueness constraint to vanity_name
class SteamProfile < ApplicationRecord
  validates :vanity_name, presence: true

  before_create :ensure_steam_id

  scope :for_vanity_name, lambda { |vanity_name|
    where('vanity_name = ?', vanity_name)
  }

  private

  # This method, designed to be called on before_create, automatically
  # fetches the steam_id for this profile if one does not exist.
  def ensure_steam_id
    return true if steam_id
    self.steam_id = SteamService.steam_id_for(vanity_name)
  end
end
