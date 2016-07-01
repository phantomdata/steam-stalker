# Domain model object to act as a decorated join between SteamProfiles and
# their games
class LibraryEntry < ApplicationRecord
  belongs_to :game

  scope :recent, -> { where(recently_played: true) }
  scope :favorites, -> { order(:playtime_in_hours).limit(5) }

  validates :playtime_in_hours, presence: true
  validates :playtime_in_hours, numericality: { only_integer: true }
end
