module Admin
  class CategoriesController < ApplicationController
    def index
      scope = Category.order(id: :desc)
      @categories = CategoryDecorator.decorate_collection(scope)
    end

    def new
      set_categories
    end

    def edit
      category = Category.find(params[:id])
      gon.category = CategorySerializer.new(category).as_json
      set_categories Category.where.not(id: category.id)
    end

    def destroy
      category = Category.find(params[:id])
      category.destroy!
      redirect_back
    end

    private

    def set_categories(categories = Category)
      gon.categories = categories.order(id: :desc).map do |c|
        CategorySerializer.new(c).as_json
      end
    end
  end
end