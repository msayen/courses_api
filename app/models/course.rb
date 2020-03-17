class Course < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :enrollments

  def self.all_courses
    enrollments_by_course = Enrollment.group(:course_id).count
    Course.all.map do |course|
      {
        id: course.id,
        name: course.name,
        enrolled: enrollments_by_course[course.id] || 0
      }
    end
  end

  def enroll(user_id)
    raise EnrollmentError, 'User already enrolled' if enrollment_exists?(id, user_id)

    enrollment = Enrollment.new(course_id: id, user_id: user_id)
    enrollment.save!
    enrollment
  end

  def enrollment_exists?(course_id, user_id)
    Enrollment.find_by(course_id: course_id, user_id: user_id).present?
  end

  class EnrollmentError < RuntimeError
  end
end
