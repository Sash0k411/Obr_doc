class Page::Create < Page::Base

  def execute
    @model = Page.create(inputs)
    errors.merge!(@model.errors) if @model.invalid?
  end
end