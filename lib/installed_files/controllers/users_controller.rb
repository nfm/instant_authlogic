class UsersController < ApplicationController
  before_filter :require_administrator
  before_filter :get_user, :except => [ :index, :new, :create ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Created user '#{@user}'"
    else
      flash[:error] = "Unable to create user"
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => "Updated user '#{@user}'"
    else
      flash[:error] = "Unable to update user"
      render :action => :edit
    end
  end

  def destroy
    if @user.delete
      redirect_to users_path, :notice => "Permanently deleted user '#{@user}'"
    else
      flash[:error] = "Unable to delete user"
      render :action => :index
    end
  end
end
