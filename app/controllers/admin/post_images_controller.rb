class Admin::PostImagesController < ApplicationController
  before_action :authenticate_admin!

  def top
  end

  def index
    if params[:tag_id]
     @tag = Tag.find(params[:tag_id])
     @post_images = @tag.post_images.all.page(params[:page]).reverse_order
    else
     @post_images = PostImage.page(params[:page]).reverse_order
    end
    @post_image = PostImage.new
    @tag_list = Tag.all
  end

  def create
    tag_list = params[:post_image][:tag_name].split(nil)
    if @post_image.save
       @post_image.save_tag(tag_list)
      redirect_to admin_post_images_path
    else
      render "new"
    end
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def edit
    @post_image = PostImage.find(params[:id])
    render "edit"
  end

   def update
     @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to admin_post_image_path(@post_image), notice: "内容更新しました。"
    else
      render "edit"
    end
   end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to admin_post_images_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :description)
  end
end