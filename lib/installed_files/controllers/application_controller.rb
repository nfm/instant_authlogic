class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password
  layout 'default'

  before_filter :require_user
  helper_method :current_user

private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session and current_user_session.record
  end

  def require_user
    unless current_user
			session[:previous_page] = request.request_uri
      redirect_to login_path, :notice => 'Log in to access your account'
      return false
    end
  end

  def require_administrator
    unless current_user and current_user.administrator?
      redirect_to dashboard_path
      return false
    end
  end

  def get_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
end
