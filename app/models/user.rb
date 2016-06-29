class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :vanity_name, presence: true
  validates :vanity_name, length: { maximum: 254 }
end
