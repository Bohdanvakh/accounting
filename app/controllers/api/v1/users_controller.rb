module Api
  module V1
    class UsersController < ApplicationController
      before_action :check_if_user_exists, only: [:create, :confirm_user]

      def create
        if @user # return if user exists
          render json: { error: 'User already exists' }, status: :conflict
          return
        end

        @user = User.new(username: params[:username], phone_number: params[:phone_number]) # create new user if not exists

        if @user
          @user.save
          @user.set_phone_confirmation_token

          TwilioService.new.send_sms(@user, @user.phone_confirmation_token)
          render json: { message: "Confirmation code was sent to #{@user.phone_number}" }, status: :ok
        end
      end

      def confirm_user
        if @user.token_not_expired?
          result = @user.set_user_confirmed(params[:confirmation_code])
          if result[:success]
            render json: { message: result[:message] }, status: :ok
          else
            render json: { message: result[:message] }, status: :unauthorized
          end
        else
          render json: { error: 'Token expired.' }, status: :unauthorized
        end
      end

      private

      def check_if_user_exists
        @user = User.find_by(phone_number: params[:phone_number])
      end
    end
  end
end
