class Document < ApplicationRecord
    include SeoHelper
    include SpreadsheetArchitect

    belongs_to :category, optional: true
    belongs_to :file, optional: true, class_name: "Document::File", foreign_key: :file_id

    validates :slug, uniqueness: true

    def url
        "#{category.url}/document/#{slug}"
    end

    def spreadsheet_columns
        [
          ['id', :id],
          ['title', :title],
          ['description', :description],
          ['slug', :slug],
          ['seo_title', :seo_title],
          ['seo_description', :seo_description],
          ['seo_keywords', :seo_description],
          ['category', category.slug]
        ]
     end
end
