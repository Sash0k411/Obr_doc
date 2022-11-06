class Category::Create < Category::Base

  def execute
    parent = Category.find_by(id: parent_id)
    @model = Category.create(inputs.except(:parent_id).merge(parent: parent))
    errors.merge!(@model.errors) if @model.invalid?
  end
end