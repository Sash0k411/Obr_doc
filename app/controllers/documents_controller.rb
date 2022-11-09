class DocumentsController < ApplicationController
  def show
    @document = Document.find_by!(slug: params[:slug])
  end
end