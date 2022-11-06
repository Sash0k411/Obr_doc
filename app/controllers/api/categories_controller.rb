module Api
  class CategoriesController < ApplicationController
    def create
      result = Category::Create.run(category_params)
      if result.valid?
        render json: ::CategorySerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    def update
      category = Category.find(params[:id])
      result = Category::Update.run(category_params.merge(model: category))
      if result.valid?
        render json: ::CategorySerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    private

    def category_params
      params[:category] || {}
    end
  end
end