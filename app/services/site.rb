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

      ar + other
    end

    def other
      [
        {
          url: "/",
          title: "Главная"
        },
        {
          url: "/sitemap",
          title: "Карта сайта"
        }
      ]
    end

    def warm(prefix = Settings.prod_host)
      urls.each do |data|
        RestClient.get("#{prefix}#{data[:url]}")
      end
    end
  end
end