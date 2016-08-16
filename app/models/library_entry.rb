# Domain model object to act as a decorated join between SteamProfiles and
# their games
class LibraryEntry < ApplicationRecord
  belongs_to :game
  belongs_to :steam_profile

  scope :recent, lambda {
    where(recently_played: true)
      .order('playtime_in_hours desc')
  }
  scope :favorites, -> { order('playtime_in_hours desc').limit(5) }

  validates :playtime_in_hours, presence: true
  validates :playtime_in_hours, numericality: { only_integer: true }

  delegate :name, to: :game
  delegate :icon_url, to: :game
  delegate :store_link, to: :game
end
