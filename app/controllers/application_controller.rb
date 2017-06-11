class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate

  layout :layout_by_resource

  def authenticate
    unless ENV['HTTP_AUTH_USERNAME'].blank? or ENV['HTTP_AUTH_PASSWORD'].blank?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USERNAME'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    end
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
  def layout_by_resource
    devise_controller? ? "devise" : false
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      employee_dashboard_path
    end
  end

end
