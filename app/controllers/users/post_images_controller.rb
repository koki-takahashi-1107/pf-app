class Users::PostImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    tag_list = params[:post_image][:tag_name].split(nil)
    if @post_image.save
       tags = Vision.get_image_data(@post_image.image)
       pp tag_list
       pp tags
       @post_image.save_tag(tag_list+tags)
      redirect_to post_images_path
    else
      render "new"
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post_image.tags
  end

  def index
    @post_images = PostImage.page(params[:page]).reverse_order
    @post_image = PostImage.new
    @tag_list = Tag.all
  end

  def edit
    @post_image = PostImage.find(params[:id])
    @users = current_user
   if @post_image.user == current_user
    render "edit"
   else
    redirect_to post_images_path
   end
  end

   def update
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: "内容更新しました。"
    else
      render "edit"
    end
   end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end


  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @post_images = @tag.post_images.all.page(params[:page]).reverse_order
    render "index"
  end

  private
  def post_image_params
    params.require(:post_image).permit(:title, :image, :description)
  end

  def ensure_correct_user
    @post_image = PostImage.find(params[:id])
    unless @post_image.user == current_user
      redirect_to post_images_path
    end
  end


end
