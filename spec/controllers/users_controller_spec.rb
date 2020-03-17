require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  context 'user creation' do
    it 'creates a user' do
      user_params = { email: 'a@b.com' }

      post '/api/v1/users', params: user_params

      user = User.find_by(email: user_params[:email])
      expect(user.email).to eq(user_params[:email])
    end

    it 'does not allow duplicate users' do
      user = create(:user)

      post '/api/v1/users', params: { email: user.email }

      expect(response.status).to eq(422)
    end

    it 'handles invalid email' do
      post '/api/v1/users', params: { email: 'ab.com' }

      expect(response.status).to eq(422)
    end
  end

  context 'user show and search' do
    it 'shows all users' do
      user1 = create(:user)
      user2 = create(:user)

      get '/api/v1/users'

      expect(response.status).to eq(200)
      expect(response_body).to match_array(
        [
          {
            id: user1.id,
            email: user1.email
          },
          {
            id: user2.id,
            email: user2.email
          }
        ]
      )
    end

    it 'finds user by email' do
      user = create(:user)

      get '/api/v1/users/find', params: { email: user.email }

      expect(response_body).to eq(
        id: user.id,
        email: user.email
      )
    end

    it 'handles requesting non-existent user by email' do
      get '/api/v1/users/find', params: { email: 'aaa@aa.a' }

      expect(response.status).to eq(404)
    end
  end

  context 'user deletion' do
    it 'deletes a user' do
      user = create(:user)

      delete "/api/v1/users/#{user.id}"

      expect(response.status).to eq(204)
      expect(User.find_by(id: user.id)).to be(nil)
    end

    it 'handles deleting non-existent user' do
      delete '/api/v1/users/1000000'
      expect(response.status).to eq(404)
    end
  end

  context 'user enrollments' do
    it 'fetches courses that user is enrolled to' do
      user = create(:user)
      course1 = create(:course)
      course2 = create(:course)
      enrollment1 = course1.enroll(user.id)
      enrollment2 = course2.enroll(user.id)

      get "/api/v1/users/#{user.id}/courses"

      expect(response.status).to eq(200)
      expect(response_body).to match_array(
        [
          {
            enrollment_id: enrollment1.id,
            course: {
              id: course1.id,
              name: course1.name
            }
          },
          {
            enrollment_id: enrollment2.id,
            course: {
              id: course2.id,
              name: course2.name
            }
          }
        ]
      )
    end
  end
end
