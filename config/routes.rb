Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: %i[index create destroy]
      get 'users/find', controller: :users, action: :find_by_email
      get 'users/:id/courses', controller: :users, action: :courses

      resources :courses, only: %i[index create destroy]
      post 'courses/:course_id/enroll', controller: :courses, action: :enroll
      post 'courses/:course_id/unenroll', controller: :courses, action: :unenroll
    end
  end
end
