module Api
  module V1
    class NightmaresController < ApplicationController
      before_action :set_nightmare, only: [:show, :update, :destroy]
      before_action :require_login, only: [:create, :update, :destroy]  # 認証を追加

      def index
        @nightmares = Nightmare.joins(:user).select("nightmares.*, users.name as author").where(published: true)
        render json: @nightmares
      end

      def show
        render json: @nightmare.as_json.merge(author: @nightmare.user.name)
      end

      def create
        @nightmare = current_user.nightmares.build(nightmare_params)
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

      def modify
        nightmare = params[:description]
        ending_category = params[:ending_category]
        modified_description = ChatGptService.modify_nightmare(nightmare, ending_category)
        render json: { modified_description: modified_description }
      end

      private

      def set_nightmare
        @nightmare = Nightmare.find(params[:id])
      end

      def nightmare_params
        params.require(:nightmare).permit(:user_id, :description, :modified_description, :ending_category, :published)
      end
    end
  end
end
