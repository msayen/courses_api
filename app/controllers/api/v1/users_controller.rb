module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render as_json(users)
      end

      def find_by_email
        user = User.find_by(email: params[:email])
        render user ? as_json(user) : { status: :not_found }
      end

      def create
        user = User.new(user_params)
        user.save!
        render as_json(user)
      end

      def destroy
        user = User.find(params[:id])
        user.destroy!
        render status: :no_content
      end

      def courses
        user = User.find(params[:id])
        render as_json(user.courses)
      end

      private

      def user_params
        params.permit(:email)
      end
    end
  end
end
