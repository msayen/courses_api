module Api
  module V1
    class EnrollmentsController < ApplicationController
      rescue_from Course::EnrollmentError, with: :render_enrollment_error

      def create
        course = Course.find(params[:course_id])
        course.enroll(params[:user_id])
        render_created
      end

      def destroy
        enrollment = Enrollment.find(params[:id])
        enrollment.destroy
        render_no_content
      end

      def render_enrollment_error(exception)
        render json: { message: exception.message }, status: 422
      end
    end
  end
end
