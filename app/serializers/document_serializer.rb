class DocumentSerializer < ApplicationSerializer
  attributes :id, :title, :description, :seo_title, :seo_description, :seo_keywords, :category_id,
    :slug, :file, :file_id, :file_url, :html, :file_name

  def file_url
    object.file.file.url if object.file
  end

  def file_name
    File.basename object.file.file.path if object.file
  end
end