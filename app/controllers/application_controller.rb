class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with Rails.application.secrets.basic_auth
end
