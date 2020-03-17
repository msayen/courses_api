require 'rails_helper'

describe Api::V1::CoursesController, type: :request do
  context 'course creation' do
    it 'creates a course' do
      course_params = { name: 'New Course' }

      post '/api/v1/courses', params: course_params

      course = Course.find_by(name: 'New Course')
      expect(course.name).to eq(course_params[:name])
    end

    it 'does not allow duplicate course names' do
      course = create(:course)

      post '/api/v1/courses', params: { name: course.name }

      expect(response.status).to eq(422)
    end
  end

  context 'course deletion' do
    it 'deletes a course' do
      course = create(:course)

      delete "/api/v1/courses/#{course.id}"

      expect(response.status).to eq(204)
      expect(Course.find_by(id: course.id)).to be(nil)
    end

    it 'handles deleting non-existent course' do
      delete '/api/v1/courses/1000000'
      expect(response.status).to eq(404)
    end
  end

  context 'course list' do
    it 'fetches list of courses with number of enrollments' do
      course1 = create(:course)
      course2 = create(:course)
      course3 = create(:course)
      course4 = create(:course)

      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)
      user5 = create(:user)

      course1.enroll(user1.id)
      course1.enroll(user2.id)
      course1.enroll(user3.id)
      course2.enroll(user4.id)
      course3.enroll(user4.id)
      course3.enroll(user5.id)

      get '/api/v1/courses'

      expect(response.status).to eq(200)
      expect(response_body).to match_array(
        [
          {
            id: course1.id,
            name: course1.name,
            enrolled: 3
          },
          {
            id: course2.id,
            name: course2.name,
            enrolled: 1
          },
          {
            id: course3.id,
            name: course3.name,
            enrolled: 2
          },
          {
            id: course4.id,
            name: course4.name,
            enrolled: 0
          }
        ]
      )
    end
  end
end
