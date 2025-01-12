module Api
  module V1
    class FoldersController < ApplicationController
      before_action :authenticate!

      def index
        render json: { folders: current_user.folders }, status: :ok
      end
    end
  end
end
