class Document::Update < Document::Base
  object :model, class: Document

  def execute
    @model.update(inputs.except(:model))
    errors.merge!(@model.errors) if @model.invalid?
  end
end