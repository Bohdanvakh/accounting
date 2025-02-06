module Api
  module V1
    class ComponentsController < ApplicationController
      before_action :authenticate!
      before_action :get_folder, only: [:index, :create, :show]
      before_action :get_component, only: [:show]

      def index
        if @folder
          render json: { components: @folder.components_with_dimension }, status: :ok
        else
          render json: { error: "Folder with ID: #{params[:folder_id]} not found" }, status: :not_found
        end
      end

      def create
        component = @folder.components.new(component_params)
        if component.save
          render json: { component: component.with_dimension }, status: :ok
        else
          render json: { error: component.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        if @component
          render json: { component: @component.with_dimension }, status: :ok
        else
          render json: { error: "Component with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      private

      def get_folder
        @folder = Folder.find(params[:folder_id])
      end

      def get_component
        @component = @folder.components.find_by(id: params[:id])
      end

      def component_params
        params.permit(:name, :price, :currency, :weight, :measurement)
      end
    end
  end
end
