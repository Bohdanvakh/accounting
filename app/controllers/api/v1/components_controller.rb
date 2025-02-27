module Api
  module V1
    class ComponentsController < ApplicationController
      before_action :authenticate!
      before_action :get_folder, only: [:index, :create, :show, :update, :destroy]
      before_action :get_component, only: [:show, :update, :destroy]

      def index
        if @folder
          render json: { components: detailded_components(params[:folder_id],
                                                          params[:name],
                                                          params[:order_by]) }, status: :ok
        else
          render json: { error: "Folder with ID: #{params[:folder_id]} not found" }, status: :not_found
        end
      end

      def create
        component = @folder.components.new(component_params)
        if component.save
          render json: { component: component.with_dimension }, status: :ok
        else
          render json: { error: component.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        if @component
          render json: { component: @component.with_dimension }, status: :ok
        else
          render json: { error: "Component with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      def update
        if @component
          @component.update!(component_params) # update if valid. If not render validation errors.
          render json: @component
        else
          render json: { error: "Component with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      def destroy
        if @component
          @component.destroy!
          render json: { message: "Component with ID: #{params[:id]} deleted" }, status: :ok
        else
          render json: { error: "Component with ID: #{params[:id]} not found" }, status: :not_found
        end
      end

      private

      def detailded_components(folder_id, name, order_by)
        folder = Folder.find(folder_id)
        components = folder.components
        return "There are no components in this folder." if components.empty?

        components = components.by_name(name) if name
        components = components.lower_price if order_by == 'lower_price'
        components = components.higher_price if order_by == 'higher_price'

        components.map do |component|
          {
            id: component.id,
            name: component.name,
            code: component.code,
            price: {
              value: component.price,
              currency: component.currency
            },
            weight: {
              value: component.weight,
              measurement: component.measurement
            }
          }
        end
      end

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
