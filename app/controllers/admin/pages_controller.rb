module Admin
  class PagesController < ApplicationController
    def index
     @pages = Page.order(id: :desc)
    end

    def edit
      page = Page.find(params[:id])
      gon.page = PageSerializer.new(page).as_json
    end

    def destroy
      page = Page.find(params[:id])
      page.destroy!
      redirect_back
    end

  end
end