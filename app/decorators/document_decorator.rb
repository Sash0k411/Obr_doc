class DocumentDecorator < ApplicationDecorator
  delegate_all

  def file_url
    object.file.file.url if object.file
  end

  def file_name
    File.basename object.file.file.path if object.file
  end

  def short_file_name
    name = file_name
    name.size > 20 ? name.first(20) + "..." : name
  end

  def category_tree
    if category = object.category
      CategoryDecorator.new(category).category_tree
    end
  end
end