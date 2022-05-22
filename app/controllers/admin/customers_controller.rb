class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.page(params[:page]).per(1)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

 def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.last_name + @customer.first_name}さんの会員情報を更新しました"
       redirect_to admin_customer_path(@customer.id)
    else
       render :edit
    end
 end
 
 def order_index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.order("created_at DESC").page(params[:page]).per(1)
 end


 private
 def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
 end
end
