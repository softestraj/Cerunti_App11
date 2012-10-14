class UsersController < ApplicationController

before_filter :require_no_user, :only => [:new, :create]
before_filter :require_user, :only => [:edit, :update, :destroy, :show, :index]

  def index
  @users = User.find(:all)
  end

  def new
   @user = User.new
  end

  def create
      @user = User.new(params[:user])
	  if @user.save
	  flash[:message] = "Welcome To Cerunti" 
	  else
	  flash[:error] = "Problem with creating your account" 
	  end
	  redirect_to root_path
  end

  def show
  @user = User.find_by_id(current_user.id)
  end

  def edit
  @user = User.find_by_id(current_user.id)
  end

  def update
    @user = User.find_by_id(current_user.id)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your Profile is Updated"
      redirect_to :action => :show
    else
      flash[:error] = "Problem with update profile"
      render :action => :edit
    end
  end
end
