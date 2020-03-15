class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  has_many :enrollments
end
