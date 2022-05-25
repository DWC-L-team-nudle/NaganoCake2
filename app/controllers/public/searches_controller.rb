class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @word = params[:word]
    if params[:word].present?
      @items = Item.where('name LIKE ?', "%#{params[:word]}%").page(params[:page]).per(9)
    else
      @word = "全商品"
      @items = Item.all.page(params[:page]).per(9)
    end
  end
end
