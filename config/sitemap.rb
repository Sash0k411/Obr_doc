require 'sitemap_generator'

Kernel.system("rm #{Rails.root}/public/sitemap.xml")

SitemapGenerator::Sitemap.default_host = Settings.prod_host
SitemapGenerator::Sitemap.create do
  Site.urls.each do |data|
    add(data[:url], priority: 1)
  end
end