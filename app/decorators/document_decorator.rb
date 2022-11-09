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
    if category
      CategoryDecorator.new(category).category_tree
    end
  end

  def category
    @category ||= object.category
  end

  def same_documents
    if category
      Document.where(category_id: category.subtree_ids).where.not(id: id).last(10).map do |doc|
        DocumentDecorator.new(doc)
      end
    end
  end

end