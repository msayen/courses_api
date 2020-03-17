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
        render_json(user.all_enrollments)
      end

      private

      def user_params
        params.permit(:email)
      end
    end
  end
end
