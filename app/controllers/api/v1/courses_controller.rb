module Api
  module V1
    class CoursesController < ApplicationController
      def index
        enrollments_by_course = Enrollment.group(:course_id).count
        result = Course.all.map do |course|
          {
            id: course.id,
            name: course.name,
            enrolled: enrollments_by_course[course.id] || 0
          }
        end
        render_json(result)
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
