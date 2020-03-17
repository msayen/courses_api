class AddUniqueConstraintToEnrollment < ActiveRecord::Migration[5.2]
  def change
    remove_index :enrollments, %i[course_id user_id]
    remove_index :enrollments, %i[user_id course_id]
    add_index :enrollments, %i[user_id course_id], unique: true
    add_index :enrollments, %i[course_id user_id], unique: true
  end
end
