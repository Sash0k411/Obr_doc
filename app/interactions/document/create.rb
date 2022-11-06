class Document::Create < Document::Base

  def execute
    @model = Document.create(inputs)
    errors.merge!(@model.errors) if @model.invalid?
  end
end