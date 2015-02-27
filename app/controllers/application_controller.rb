class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :auth_session

  def auth_session
    return if ['login', 'login_submit'].include?(params[:action]) || session[:auth]
    redirect_to login_path
  end
end
