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

      def show
        begin
        folder = current_user.folders.find(params[:id])
        render json: { folder: folder }, status: :ok
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Folder with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      def destroy
        begin
          folder = current_user.folders.find(params[:id])
          folder.destroy
          render json: { message: "Folder with ID: #{params[:id]} deleted" }, status: :ok
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Folder with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      private

      def folder_params
        params.permit(:name)
      end
    end
  end
end
