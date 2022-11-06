class CategoryDecorator < ApplicationDecorator
  delegate_all

  def category_tree
    object.parents.map(&:title).push("<b>#{object.title}</b>").join(" -> ").html_safe
  end
end