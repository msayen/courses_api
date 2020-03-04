class CreateJoinTableCourseUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :courses, :users do |t|
      t.index %i[course_id user_id]
      t.index %i[user_id course_id]
    end
  end
end
