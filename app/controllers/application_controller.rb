class ApplicationController < ActionController::Base
  require 'rest-client'
  helper_method :base_url

    def base_url
    "http://localhost:4042"
    end
end
