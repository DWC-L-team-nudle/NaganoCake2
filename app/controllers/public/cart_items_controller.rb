class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end


  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?

       cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

       cart_item.amount = cart_item.amount+params[:cart_item][:amount].to_i
       cart_item.save
       flash[:notice] = "カートに商品が追加されました"
       redirect_to cart_items_path

    else
       @cart_item.save
    end
       redirect_to cart_items_path
  end


    def update
      @cart_item = CartItem.find(params[:id])
      @cart_item.update(cart_item_params)
      flash[:notice] = "商品を更新しました"
      redirect_to cart_items_path
    end


    def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      flash[:alert] = "商品を削除しました"
      redirect_to cart_items_path
    end


    def destroy_all
      @cart_items = current_customer.cart_items.all
      @cart_items.destroy_all
      flash[:alert] = "カートの商品を全て削除しました"
      redirect_to cart_items_path
    end


    private

    def cart_item_params
       params.require(:cart_item).permit(:item_id, :amount)
    end

end
