# This class represents a given Steam user's basic metadata.
# TODO: Add uniqueness constraint to vanity_name
class SteamProfile < ApplicationRecord
  validates :vanity_name, presence: true

  scope :for_vanity_name, ->(vanity_name) {
    where('vanity_name = ?', vanity_name)
  }
end
