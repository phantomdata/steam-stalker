class LibraryEntry < ApplicationRecord
  belongs_to :game

  scope :recent, -> { where(recently_played: true) }

  validates :playtime_in_hours, presence: true
  validates :playtime_in_hours, numericality: { only_integer: true }
end
