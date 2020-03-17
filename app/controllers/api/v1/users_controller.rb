module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render_json(users)
      end

      def find_by_email
        user = User.find_by(email: params[:email])
        user ? render_json(user) : render_not_found
      end

      def create
        user = User.new(user_params)
        user.save!
        render_json(user)
      end

      def destroy
        user = User.find(params[:id])
        user.destroy!
        render_no_content
      end

      def courses
        user = User.find(params[:id])
        enrollments = user.enrollments
        courses_by_id = Course.where(id: enrollments.map(&:course_id))
                              .map { |course| [course.id, course] }.to_h
        result = enrollments.map do |enrollment|
          {
            enrollment_id: enrollment.id,
            course: courses_by_id[enrollment.course_id]
          }
        end
        render_json(result)
      end

      private

      def user_params
        params.permit(:email)
      end
    end
  end
end
