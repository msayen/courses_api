class Course < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :enrollments

  def enroll(user_id)
    raise EnrollmentError, 'User already enrolled' if enrollment_exists?(id, user_id)

    e = Enrollment.new(course_id: id, user_id: user_id)
    e.save!
    e
  end

  def enrollment_exists?(course_id, user_id)
    Enrollment.find_by(course_id: course_id, user_id: user_id).present?
  end

  class EnrollmentError < RuntimeError
  end
end
