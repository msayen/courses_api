class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, email: true
  has_many :enrollments

  def all_enrollments
    courses_by_id = Course.where(id: enrollments.map(&:course_id)).index_by(&:id)
    enrollments.map do |enrollment|
      {
        enrollment_id: enrollment.id,
        course: courses_by_id[enrollment.course_id]
      }
    end
  end
end
