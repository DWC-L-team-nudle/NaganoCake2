class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: 1).page(params[:page]).per(9)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end


private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :price)
  end
end
