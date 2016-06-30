# This class represents a given Steam user's basic metadata.
# TODO: Add uniqueness constraint to vanity_name
class SteamProfile < ApplicationRecord
  validates :steam_id, presence: true
  validates :vanity_name, presence: true

  scope :for_vanity_name, lambda { |vanity_name|
    where('vanity_name = ?', vanity_name)
  }

  def vanity_name=val
    write_attribute(:vanity_name, val)
    update_steam_id
  end

  private

  # This method, designed to be called on before_create, automatically
  # fetches the steam_id for this profile if one does not exist.
  def update_steam_id
    self.steam_id = SteamService.steam_id_for(vanity_name)
  end
end
