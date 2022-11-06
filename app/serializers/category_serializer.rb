class CategorySerializer < ApplicationSerializer
  attributes :id, :title, :description, :seo_title, :seo_description, :seo_keywords,
    :parent_id, :parent_ids, :slug

#   def parents
#     object.parents.map do |c|
#       {
#         id: c.id,
#         title: c.title
#       }
#     end
#   end
end