module Api
  module V1
    class NightmaresController < ApplicationController
      before_action :set_nightmare, only: [:show, :update, :destroy]

      def index
        @nightmares = Nightmare.joins(:user).select("nightmares.*, users.name as author").where(published: true)
        render json: @nightmares
      end

      def show
        render json: @nightmare
      end

      def create
        @nightmare = Nightmare.new(nightmare_params)
        if @nightmare.save
          render json: @nightmare, status: :created
        else
          render json: @nightmare.errors, status: :unprocessable_entity
        end
      end

      def update
        if @nightmare.update(nightmare_params)
          render json: @nightmare
        else
          render json: @nightmare.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @nightmare.destroy
      end

      private

      def set_nightmare
        @nightmare = Nightmare.find(params[:id])
      end

      def nightmare_params
        params.require(:nightmare).permit(:user_id, :description, :modified_description, :ending_type, :published)
      end
    end
  end
end
