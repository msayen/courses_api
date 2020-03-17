require 'rails_helper'

describe Api::V1::EnrollmentsController, type: :request do
  it 'enrolls a user' do
    course = create(:course)
    user = create(:user)

    post '/api/v1/enrollments', params: { user_id: user.id, course_id: course.id }

    expect(response.status).to eq(201)
    expect(Enrollment.find_by(user_id: user.id, course_id: course.id)).not_to be_nil
  end

  it 'handles enrolling for non-existent course' do
    user = create(:user)

    post '/api/v1/enrollments', params: { user_id: user.id, course_id: 1_000_000 }

    expect(response.status).to eq(404)
    expect(response_body[:message]).to match(/Course/)
  end

  it 'handles enrolling of non-existent user' do
    course = create(:course)

    post '/api/v1/enrollments', params: { user_id: 1_000_000, course_id: course.id }

    expect(response.status).to eq(422)
    expect(response_body[:message]).to match(/User/)
  end

  it 'handles double enrollment' do
    course = create(:course)
    user = create(:user)
    course.enroll(user.id)

    post '/api/v1/enrollments', params: { user_id: user.id, course_id: course.id }

    expect(response.status).to eq(422)
    expect(response_body[:message]).to match(/User/)
  end

  it 'unenrolls a user' do
    course = create(:course)
    user = create(:user)
    enrollment = course.enroll(user.id)

    delete "/api/v1/enrollments/#{enrollment.id}"

    expect(response.status).to eq(204)
    expect(Enrollment.find_by(user_id: user.id, course_id: course.id)).to be_nil
  end

  it 'handles deleting non-existent enrollment' do
    delete '/api/v1/enrollments/1000000'

    expect(response.status).to eq(404)
    expect(response_body[:message]).to match(/Enrollment/)
  end
end
