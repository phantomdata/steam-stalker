class Game < ApplicationRecord
  has_many :library_entries

  validates :appid, presence: true
end
