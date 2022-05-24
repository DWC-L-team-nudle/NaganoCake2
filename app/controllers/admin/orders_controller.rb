class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(params[:id])
    @order_detail = @order.order_details.find_by(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    flash[:notice] = "注文ステータスを更新しました"
      if @order.status == "payment_confirm"
         @order_details.update_all("making_status = 1")
      else
         redirect_to request.referer
      end
  end

  private

  def order_params
      params.require(:order).permit(:status)
  end
end
