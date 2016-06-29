# This class represents a user within the system for authentication,
# authorization and interaction purposes.  They are currently the only type
# of acting agent within the system.
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :vanity_name, presence: true
  validates :vanity_name, length: { maximum: 254 }
end
