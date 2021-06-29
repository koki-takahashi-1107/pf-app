class GoodsController < ApplicationController
  def search
    if params[:keyword].blank?

    elsif params[:keyword].present? && params[:keyword].length < 2
      redirect_to rakuten_path, notice: '2文字以上入力してください'
      
    else
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
      
    end
  end
end
