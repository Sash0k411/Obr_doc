class Document < ApplicationRecord
    include SeoHelper
    belongs_to :category, optional: true
    belongs_to :file, optional: true, class_name: "Document::File", foreign_key: :file_id
end
