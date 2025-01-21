module Api
  module V1
    class SessionsController < ApplicationController
      before_action :find_user, only: [:authenticate_phone_number, :create]
      before_action :authenticate!, only: [:destroy]

      def authenticate_phone_number
        if @user
          @user.set_phone_confirmation_token

          TwilioService.new.send_sms(@user, @user.phone_confirmation_token)
          render json: { message: "Confirmation code was sent to #{@user.phone_number}" }, status: :ok
        end
      end

      def create
        if @user && @user.phone_confirmation_token && @user.confirmed
          result = @user.confirm_phone(params[:confirmation_code])
          if result[:success]
            current_user.update!(active: true)
            render json: { token: @user.generate_jwt_token,  message: 'Logged in successfully.' }, status: :ok
          else
            render json: { message: result[:message] }, status: :ok
          end
        else
          render json: { error: 'Invalid credentials or unverified phone number.' }, status: :unauthorized
        end
      end

      def destroy
        # in the frontend part of sign out logic we remove jwt token from local storage.
        current_user.update!(active: false)
      end

      private

      def find_user
        @user = User.find_by(phone_number: params[:phone_number])
      end
    end
  end
end
