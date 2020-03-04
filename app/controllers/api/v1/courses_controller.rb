module Api
  module V1
    class CoursesController < ApplicationController
      rescue_from Course::EnrollmentError, with: :render_enrollment_error

      def index
        courses = Course.all.map do |course|
          {
            id: course.id,
            name: course.name,
            enrolled: course.users.size
          }
        end
        render as_json(courses)
      end

      def create
        course = Course.new(course_params)
        course.save!
        render as_json(course)
      end

      def destroy
        course = Course.find(params[:id])
        course.destroy!
        render status: :no_content
      end

      def enroll
        course = Course.find(params[:course_id])
        course.enroll(params[:user_id])
        render status: :ok
      end

      def unenroll
        course = Course.find(params[:course_id])
        course.unenroll(params[:user_id])
        render status: :ok
      end

      private

      def course_params
        params.permit(:name)
      end

      def render_enrollment_error(exception)
        render json: { message: exception.message }, status: 422
      end
    end
  end
end
