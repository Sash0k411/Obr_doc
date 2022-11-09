module Admin
  class ApplicationController < ::ApplicationController
    http_basic_authenticate_with name: ENV["USERNAME"],password: ENV["PASSWORD"]

    layout 'admin'

    def main
      render 'admin/main'
    end
  end
end