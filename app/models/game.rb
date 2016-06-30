# Domain model object to represent Games which have been fetched from Steam
class Game < ApplicationRecord
  has_many :library_entries

  validates :appid, presence: true
end
