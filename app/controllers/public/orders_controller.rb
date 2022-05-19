class Public::OrdersController < ApplicationController
  def index
    customer = Customer.find_by(params[:customer_id])
    @orders = customer.orders.order(created_at: :desc)
  end

  def show
    @orders = Order.find(params[:id])
  end
end
