if User.count.zero?
  10.times do
    User.create!(
      email: Faker::Internet.email
    )
  end
end

if Course.count.zero?
  5.times do
    course = Course.create!(
      name: Faker::Educator.course_name
    )

    course.enroll(User.order('RANDOM()').first.id)
  end
end
