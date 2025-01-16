module Api
  module V1
    class FoldersController < ApplicationController
      before_action :authenticate!

      def index
        render json: { folders: current_user.folders }, status: :ok
      end

      def create
        folder = current_user.folders.new(folder_params)
        if folder.save
          render json: { folder: folder }, status: :ok
        else
          render json: { error: folder.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def folder_params
        params.permit(:name)
      end
    end
  end
end

