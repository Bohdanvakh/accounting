module Api
  module V1
    class ComponentsController < ApplicationController
      # before_action :authenticate!
      before_action :get_folder, only: [:index]

      def index
        if @folder
          render json: { components: components_with_dimension }, status: :ok
        else
          render json: { error: "Folder with ID: #{params[:folder_id]} not found" }, status: :not_found
        end
      end

      def get_folder
        @folder = Folder.find(params[:folder_id])
      end

      private

      def components_with_dimension
        @folder.components.includes(:dimension).map do |component|
          {
            id: component.id,
            name: component.name,
            folder: component.folder_id,
            price: component.price,
            code: component.code,
            name: component.name,
            wieght: component.wieght,
            measurement: component.measurement,
            currency: component.currency,
            dimension: component.dimension
          }
        end
      end
    end
  end
end
