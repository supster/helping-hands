class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to Helping Hands"
      sign_in @user
      redirect_to @user
    else
      render "new"      
    end
  end
  
  def edit
  
  end
  
  def update
    if @user.update_attributes(params[:user])
      #handle successful update
      sign_in @user
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end
  
  private
  
  def signed_in_user
    unless signed_in? 
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_path      
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end  
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end