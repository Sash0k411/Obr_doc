class Category < ApplicationRecord
  include Tree
  has_many :documents, dependent: :nullify

  validates :slug, uniqueness: true
end
