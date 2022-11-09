class Category < ApplicationRecord
  include Tree
  has_many :documents, dependent: :nullify
  validates :slug, uniqueness: true

  def url
    "/c/#{parents.any? ? parents.map(&:slug).join("/") + '/' : ''}#{slug}"
  end
end
