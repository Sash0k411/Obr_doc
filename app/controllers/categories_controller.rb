class CategoriesController < ApplicationController

  # extend PageCache
  caches_page :show, :index
  before_action :set_category, only: [:show]

  def show
    set_meta_tags @category
  end

  private

  def set_category
    slug_1, slug_2, slug_3, slug_4 = params[:c_1], params[:c_2], params[:c_3], params[:c_4]
    categories = [slug_1, slug_2, slug_3, slug_4].compact.map { |slug| Category.includes(documents: :file).find_by!(slug: slug) }
    @category = categories.last
  end
end