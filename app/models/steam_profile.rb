# This class represents a given Steam user's basic metadata.
# TODO: Add uniqueness constraint to vanity_name
class SteamProfile < ApplicationRecord
  has_many :games, through: :library_entries
  has_many :library_entries

  validates :steam_id, presence: true
  validates :vanity_name, presence: true

  scope :for_vanity_name, lambda { |vanity_name|
    where('vanity_name = ?', vanity_name)
  }

  # Not quite a scope; this is used to map out the favrite games of a particular
  # profile.
  def favorite_games
    library_entries.favorites.map(&:game)
  end

  # Not quite a scope; this is used to map out the games recently played
  # by this steam_profile based on its relationships
  def recent_games
    library_entries.recent.map(&:game)
  end

  def update_library
    SteamService.update_library_for(self)
  end

  # Setter override to ensure information derived from the SteamAPI is updated
  # whenever the vanity_name is changed.
  def vanity_name=(val)
    self[:vanity_name] = val
    update_steam_id
    update_library
  end

  private

  # This method, designed to be called on before_create, automatically
  # fetches the steam_id for this profile if one does not exist.
  def update_steam_id
    self.steam_id = SteamService.steam_id_for(vanity_name)
  end
end
