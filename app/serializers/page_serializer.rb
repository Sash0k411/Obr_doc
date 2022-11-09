class PageSerializer < ApplicationSerializer
  attributes :id, :title, :description, :seo_title, :seo_description, :seo_keywords, :slug
end