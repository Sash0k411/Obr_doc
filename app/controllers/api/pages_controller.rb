module Api
  class PagesController < ApplicationController

    def create
      result = Page::Create.run(page_params)
      if result.valid?
        render json: ::PageSerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    def update
      page = Page.find(params[:id])
      result = Page::Update.run(page_params.merge(model: page))
      if result.valid?
        render json: ::PageSerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    private

    def page_params
      params[:page] || {}
    end
  end
end