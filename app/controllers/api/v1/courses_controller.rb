module Api
  module V1
    class CoursesController < ApplicationController
      def index
        courses = Course.all.map do |course|
          {
            id: course.id,
            name: course.name,
            enrolled: Enrollment.where(course_id: course.id).count
          }
        end
        render_json(courses)
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
