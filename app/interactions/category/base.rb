class Category::Base < ApplicationInteraction
  string :title
  string :description
  string :seo_title, default: nil
  string :seo_description, default: nil
  string :seo_keywords, default: nil
  string :slug, default: -> { Russian::transliterate("#{title}-#{Category.last&.id.to_i + 1}").parameterize }
  integer :parent_id, default: nil

  validates :title, presence: true
  validates :description, presence: true
end