module Api
  module V1
    class CoursesController < ApplicationController
      def index
        render_json(Course.all_courses)
      end

      def create
        course = Course.new(course_params)
        course.save!
        render_json(course)
      end

      def destroy
        course = Course.find(params[:id])
        course.destroy!
        render_no_content
      end

      private

      def course_params
        params.permit(:name)
      end
    end
  end
end
