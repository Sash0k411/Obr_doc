class Page::Update < Page::Base
  object :model, class: Page

  def execute
    @model.update(inputs.except(:model))
    errors.merge!(@model.errors) if @model.invalid?
  end
end