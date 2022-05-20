class Public::OrdersController < ApplicationController

def index
  customer = Customer.find_by(params[:customer_id])
  @orders = customer.orders.order(created_at: :desc)
end

def show
  @orders = Order.find(params[:id])
end

def new
  @order = Order.new
  @customer = current_customer
  @address = Address.new
end

def comfirm
  @order = Order.new(order_params)
  #@order.order_status = "machi"

  if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
  elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
  elsif params[:order][:select_address] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
  else
    flash.now[:notice] = "住所を選択してください"
    render "new"
  end

    @cart_items = current_customer.cart_items
    @shopping_fee = 800
end

def create # Order に情報を保存
  cart_items = current_customer.cart_items.all
  @order = Order.new(order_params)
  @order.customer_id = current_customer.id
  if @order.save
    cart_items.each do |cart_item|
    #order_detail にもデータを保存
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      #order_detail.status =
      order_detail.price = cart_item.item.price
      order_detail.save
    end
  end
  cart_items.destroy_all
  redirect_to complete_orders_path
end

def complete
end

private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shopping_fee, :total_payment)
  end

end
