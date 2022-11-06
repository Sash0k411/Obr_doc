class Category::Update < Category::Base
  object :model, class: Category

  def execute
    parent = Category.find_by(id: parent_id)
    @model.update(inputs.except(:model, :parent_id).merge(parent: parent))
    errors.merge!(@model.errors) if @model.invalid?
  end
end