module Api
  class DocumentsController < ApplicationController

    def create
      result = Document::Create.run(document_params)
      if result.valid?
        render json: ::DocumentSerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    def update
      document = Document.find(params[:id])
      result = Document::Update.run(document_params.merge(model: document))
      if result.valid?
        render json: ::DocumentSerializer.new(result.model).as_json
      else
        render json: { errors: result.errors }, status: 422
      end
    end

    private

    def document_params
      params[:document] || {}
    end
  end
end