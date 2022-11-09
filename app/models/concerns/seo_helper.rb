module SeoHelper
  def to_meta_tags
    {
      title: seo_title,
      description: seo_description,
      keywords: seo_keywords,
      og: {
        title: seo_title,
        url: try(:url)
      }
    }
  end
end