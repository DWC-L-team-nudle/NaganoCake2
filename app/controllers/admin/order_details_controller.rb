class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = Order.find_by(id: @order_detail.order_id)
    @order_details = @order.order_details
    flash[:notice] = "製作ステータスを変更しました"
    if @order_detail.making_status == "making"
       @order.update_attribute(:status, 2)
       redirect_to request.referer
    elsif @order_details.count == @order_details.where(making_status: "completion").count
      # 注文詳細のレコードをカウントして、製作ステータスの製作完了の数と同じなら注文ステータスの表示を発送準備中へ変更する。
      @order.update(status: "ready_to_ship")
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
