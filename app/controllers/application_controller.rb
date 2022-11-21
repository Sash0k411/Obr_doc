class ApplicationController < ActionController::Base

  def sitemap
    render "pages/sitemap"
  end

  private

  def redirect_back
    super(fallback_location: "/")
  end

  def default_metatags
    {

    }
  end

end
