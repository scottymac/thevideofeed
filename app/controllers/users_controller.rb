class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:follow, :unfollow]

  def show
    @user = User.find_by_username! params[:id]
    @posts = @user.posts.get :page => params[:page], :include => :video
    render @posts if request.xhr?
  end

  def new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def follow
    @user = User.find_by_username! params[:user_id]
    current_user.follow @user unless current_user.following? @user
  end

  def unfollow
    @user = User.find_by_username! params[:user_id]
    current_user.unfollow @user if current_user.following? @user
    render 'users/follow'
  end

end
