describe Course do
  context 'enrollment' do
    it 'enrolls user for a course' do
      user = create(:user)
      course = create(:course)

      course.enroll(user.id)

      expect(user.courses).to include(course)
      expect(course.users).to include(user)
    end

    it 'does not allow to enroll with non-existent user' do
      course = create(:course)
      expect { course.enroll(10_000_000) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'unenroll from a course' do
      user = create(:user)
      course = create(:course)
      course.enroll(user.id)

      course.unenroll(user.id)

      expect(user.courses).not_to include(course)
      expect(course.users).not_to include(user)
    end

    it 'handle case when user was not enrolled' do
      user = create(:user)
      course = create(:course)
      expect { course.unenroll(user.id) }.to raise_error('User was not enrolled to this course')
    end
  end
end
