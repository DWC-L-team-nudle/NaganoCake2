class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]) #config/initializers/kaminari_config.rbに表示件数の指定必要(デフォルトは25件)
    # @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    #@genre = Genre.all
  end


private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :price)
  end

end
