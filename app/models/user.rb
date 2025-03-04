class User < ApplicationRecord
  # Validates user's 'username' is unique.
  validates :username, uniqueness: true
end
