module Api
  class FilesController < ApplicationController
    def create
      file = Document::File.create(file: params[:file])
      if file.valid?
        render json: FileSerializer.new(file, parse: true).as_json
      else
        render json: { errors: file.errors.messages }, status: 422
      end
    end
  end
end