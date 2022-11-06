class ApplicationController < ActionController::Base

  private

  def redirect_back
    super(fallback_location: "/")
  end

end
