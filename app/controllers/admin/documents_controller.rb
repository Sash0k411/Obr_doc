module Admin
  class DocumentsController < ApplicationController

    def index
      query = ::DocumentQuery.new(params)
      @documents = DocumentDecorator.decorate_collection(query.call)
    end

    def new
      set_categories
    end

    def edit
      document = Document.find(params[:id])
      gon.document = DocumentSerializer.new(document).as_json
      set_categories
    end

    def destroy
      document = Document.find(params[:id])
      document.destroy!
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