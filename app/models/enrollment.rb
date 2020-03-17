class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

#   def self.enroll_user(course_id, user_id)
#     # user = User.find(user_id)
#     raise EnrollmentError, 'User already enrolled' unless Enrollment.where(user_id: user_id).where(course_id: course_id).empty?

#     Enrollment.create(user_id: user_id, course_id: course_id)
#   end
end
