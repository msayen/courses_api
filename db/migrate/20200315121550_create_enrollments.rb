class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    rename_table :courses_users, :enrollments
    add_column :enrollments, :id, :primary_key
  end
end
