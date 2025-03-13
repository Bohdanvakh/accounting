module Api
  module V1
    class UsersController < ApplicationController
      before_action :check_if_user_exists, only: [:create, :confirm_user]
      before_action :authenticate!, only: [:show, :update]
      before_action :set_user, only: [:show, :update]

      def create
        if @user # return if user exists
          render json: { error: 'User already exists' }, status: :conflict
          return
        end

        @user = User.new(username: params[:username], phone_number: params[:phone_number]) # create new user if not exists

        if @user
          phone_confirmation_token = ConfirmationTokenGenerator.generate

          begin
            TwilioService.new.send_sms(@user, phone_confirmation_token)
            @user.save
            @user.update!(phone_confirmation_token: phone_confirmation_token,
                          token_sent_at: Time.now)

            render json: { message: "Confirmation code was sent to #{@user.phone_number}" }, status: :ok
            return
          rescue Twilio::REST::RestError => e
            render json: { message: "Can't send SMS verification code to #{@user.phone_number}" }, status: :conflict
          end
        end
      end

      def show
        render json: { user: @user.detailed_info }
      end

      def update
        if @user
          @user.update!(user_params)
          render json: @user
        else
          render json: { message: "Looks like user with #{@user.id} doesn't exist" }, status: :not_found
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

      def user_params
        params.permit(:username, :phone_number)
      end

      def component_params
        params.permit(:name, :price, :currency, :weight, :measurement)
      end

      def check_if_user_exists
        @user = User.find_by(phone_number: params[:phone_number])
      end

      def set_user
        @user = User.find_by(id: params[:id])
      end
    end
  end
end
