class Page::Base < ApplicationInteraction
  string :title
  string :description
  string :slug
  string :seo_title, default: nil
  string :seo_description, default: nil
  string :seo_keywords, default: nil

  validates :title, presence: true
  validates :description, presence: true
end