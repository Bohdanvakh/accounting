module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(phone_number: params[:phone_number])

        if user
          token = user.generate_jwt_token
          render json: { token: token,  message: 'Logged in successfully' }, status: :ok
        else
          render json: { error: 'Invalid credentials or unverified phone number' }, status: :unauthorized
        end
      end
    end
  end
end
