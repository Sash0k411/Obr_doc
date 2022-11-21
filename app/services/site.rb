class Site
  class << self
    def urls
      ar = []

      Category.find_each do |category|
        ar << {
          title: category.title,
          url: category.url
        }
      end

      Document.joins(:category).find_each do |document|
        ar << {
          url: document.url,
          title: document.title
        }
      end

      ar
    end
  end
end