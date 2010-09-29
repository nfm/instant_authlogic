class UserSessionsController < ApplicationController
  skip_before_filter :require_user

  def new
    if current_user
			page = session[:current_page] ? session[:current_page] : root_path
      redirect_to page, :notice => "You are already logged in"
    else
      @user_session = UserSession.new
      render :action => :new
    end
  end

  def create
    @user_session = UserSession.create(params[:user_session])
    if @user_session.save
      redirect_to root_url, :notice => "Welcome back, #{current_user}"
    else
      flash[:error] = "Invalid username/password combination"
      render :action => :new
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session and @user_session.destroy
      flash[:notice] = "Logged out"
    end
    redirect_to root_url
  end
end
