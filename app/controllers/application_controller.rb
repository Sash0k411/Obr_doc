class ApplicationController < ActionController::Base

  private

  def redirect_back
    super(fallback_location: "/")
  end

  def default_metatags
    {

    }
  end

end
