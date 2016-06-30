# This class represents a given Steam user's basic metadata.
# TODO: Add uniqueness constraint to vanity_name
class SteamProfile < ApplicationRecord
  validates :vanity_name, presence: true

  before_create :ensure_steam_id

  scope :for_vanity_name, lamda { |vanity_name|
    where('vanity_name = ?', vanity_name)
  }

  private

  def ensure_steam_id
    steam_id = SteamService.steam_id_for(vanity_name)
  end
end
