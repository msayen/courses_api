class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  has_and_belongs_to_many :courses
end
