module Api
  module V1
    class PlaceholdersController < ApplicationController
      def index
        render json: { message: "これは仮のデータです" }
      end
    end
  end
end
