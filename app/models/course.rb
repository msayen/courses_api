class Course < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :enrollments

  def enroll(user_id)
    user = User.find(user_id)
    raise EnrollmentError, 'User already enrolled' if users.include?(user)

    users << user
    save!
  end

  def unenroll(user_id)
    user = User.find(user_id)
    raise EnrollmentError, 'User was not enrolled to this course' if users.exclude?(user)

    users.delete(user)
    save!
  end

  class EnrollmentError < RuntimeError
  end
end
