module Admin
  class DocumentsController < ApplicationController

    def index
      query = ::DocumentQuery.new(params)
      @documents = DocumentDecorator.decorate_collection(query.call)
    end

    def new
      set_categories
    end

    def export
      scope = Document.includes(:category, :file)
      filename = "Document #{Time.zone.now.strftime('%H.%M %d.%m.%Y')}"
      render xlsx: Document.to_xlsx(instances: scope.to_a, sheet_name: filename), filename: filename
    end

    def import
      result = Document::Import.run(params.fetch(:import, {}))
      if result.valid?
        @message = "Import successful"
      else
        @errors = "Import failed: #{result.errors.messages}"
      end
      render other_admin_documents_path
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