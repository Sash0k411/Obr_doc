class Document::Base < ApplicationInteraction
  string :title
  string :description
  string :slug, default: -> { Russian::transliterate("#{title}-#{Document.last&.id.to_i + 1}").parameterize }
  string :seo_title, default: nil
  string :seo_description, default: nil
  string :seo_keywords, default: nil
  string :html, default: nil
  integer :category_id
  integer :file_id

  validates :title, presence: true
  validates :description, presence: true
  validate do
    unless Category.find_by(id: category_id)
      errors.add(:category_id, :invalid)
    end
  end
end