class Public::OrdersController < ApplicationController
  def index
    customer = Customer.find_by(params[:customer_id])
    @orders = customer.orders
  end

end
