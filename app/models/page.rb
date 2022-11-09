class Page < ApplicationRecord
   validates :slug, uniqueness: true
   include SeoHelper
end
