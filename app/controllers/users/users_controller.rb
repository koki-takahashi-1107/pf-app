class Users::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only: [:edit, :update]
  

  def show
    @user = User.find(params[:id])
    @post_image = PostImage.new
    @post_images = @user.post_images.page(params[:page]).reverse_order
    @tag_list = Tag.all
  end

  def index
      @users = User.all
  end

  def edit
    @user = User.find(params[:id])
   if @user == current_user
    render "edit"
   else
    redirect_to user_path(current_user)
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "ユーザー情報更新しました"
     redirect_to user_path(@user.id)
    else
     render "edit"
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    @followings = @user.followings.all

  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    @followers = @user.followers.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
