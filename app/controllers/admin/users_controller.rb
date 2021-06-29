class Admin::UsersController < ApplicationController
before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order
    @tag_list = Tag.all
  end

  def edit
    @user = User.find(params[:id])
   if @user == current_admin
    render "edit"
   else
    redirect_to admin_user_path(current_admin)
   end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "ユーザー情報更新しました"
     redirect_to dmin_user_path(@user.id)
    else
     render "edit"
    end
  end

 private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end



end
