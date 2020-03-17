class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  has_many :enrollments

  # this method is more complex than it could be, but it produces
  # a constant number of queries
  def all_enrollments
    courses_by_id = Course.where(id: enrollments.map(&:course_id))
                          .map { |course| [course.id, course] }.to_h
    enrollments.map do |enrollment|
      {
        enrollment_id: enrollment.id,
        course: courses_by_id[enrollment.course_id]
      }
    end
  end
end
