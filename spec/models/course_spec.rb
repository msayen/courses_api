describe Course do
  context 'enrollment' do
    it 'enrolls user for a course' do
      user = create(:user)
      course = create(:course)

      course.enroll(user.id)

      expect(Enrollment.find_by(course_id: course.id, user_id: user.id)).not_to be_nil
    end

    it 'does not allow to enroll with non-existent user' do
      course = create(:course)
      expect { course.enroll(10_000_000) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
