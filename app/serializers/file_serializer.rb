class FileSerializer < ApplicationSerializer
  attributes :id, :url, :html, :name

  def initialize(model, options={})
    super
    @parse = options[:parse]
  end

  def name
    File.basename object.file.path
  end

  def url
    object.file.url
  end

  def html
    return unless @parse

    doc = Docx::Document.open(object.file)
    doc.paragraphs.map do |p|
      p.to_html
    end.join("")
  end
end