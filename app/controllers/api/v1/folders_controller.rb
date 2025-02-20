module Api
  module V1
    class FoldersController < ApplicationController
      before_action :authenticate!

      def index
        render json: { folders: detailed_folders(current_user, params[:name], params[:code]) }, status: :ok
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

      def detailed_folders(user, name, code)
        folders = user.folders
        folders = folders.by_name(name) if name
        folders = folders.by_code(code) if code

        folders.includes(components: :dimension).map do |folder|
          {
            folder: folder,
            price: folder.components_price_sum,
            components_number: folder.components.size,
            area: folder.area,
            area_measurement: 'cm^3',
            weight: folder.weight,
            weight_measurement: 'kgs'
          }
        end
      end

      def folder_params
        params.permit(:name)
      end
    end
  end
end
