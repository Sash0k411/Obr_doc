class ApplicationQuery
  attr_reader :filter, :per_page, :page

  PAGE = 1
  PER_PAGE = Kaminari.config.default_per_page
  MAX_PER_PAGE = Kaminari.config.max_per_page

  def initialize(_filter = nil)
    @filter = _filter || {}
    if filter[:page]
      @page = filter[:page].to_i
    else
      @page = PAGE
    end
    if filter[:per_page]
      if filter[:per_page].to_i > MAX_PER_PAGE
        @per_page = MAX_PER_PAGE
      else
        @per_page = filter[:per_page].to_i
      end
    else
      @per_page = PER_PAGE
    end
  end

  def self.call(_filter={})
    new(_filter).call
  end

  def json_collection
    ActiveModel::Serializer::CollectionSerializer
  end

  def method_missing(m, *args)
    filter.dig(m)
  end
end