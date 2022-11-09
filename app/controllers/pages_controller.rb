class PagesController < ApplicationController
  def main
    @page = Page.find_or_create_by!(slug: :main)
      set_meta_tags @page
  end

  def show
    @page = Page.find(params[:id])
    set_meta_tags @page
  end

end