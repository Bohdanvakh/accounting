module Api
  module V1
    class UsersController < ApplicationController
      before_action :check_if_user_exists, only: [:create]

      def create
        user = User.new(username: params[:username], phone_number: params[:phone_number])

        if user
          user.save
          user.update!(phone_confirmation_token: generate_confirmation_token, token_sent_at: Time.now)

          TwilioService.new.send_sms(user, user.phone_confirmation_token)
          render json: { message: 'Confirmation code was sent. Check your phone and verify your profile' }, status: :ok
        end
      end

      def confirm_user
        user = User.find_by(phone_number: params[:phone_number])

        if token_not_expired?(user)
          set_user_confirmed(user)
        else
          render json: { error: 'Token expired.' }, status: :unauthorized
        end
      end

      private

      def check_if_user_exists
        user = User.find_by(phone_number: params[:phone_number])
        render json: { error: 'User already exists' }, status: :conflict if user
      end

      def token_not_expired?(user)
        user.token_sent_at + 3.minutes < Time.now
      end

      def set_user_confirmed(user)
        if user.phone_confirmation_token == params[:confirmation_code]
          user.update!(phone_confirmation_token, token_sent_at: nil, confirmed: true)
          render json: { message: 'User was confirmed' }, status: :ok
        else
          render json: { error: 'Wrong confirmation code' }, status: :unauthorized
        end
      end

      def generate_confirmation_token
        SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
      end
    end
  end
end
