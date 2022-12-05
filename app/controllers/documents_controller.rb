class DocumentsController < ApplicationController
  caches_page :show
  def show
    @document = Document.find_by!(slug: params[:slug])
    @document = DocumentDecorator.new(document)
    set_meta_tags @document
  end
end