class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

def not_authenticated
  redirect_to login_path, alert: "Please login first"
end

end
