class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

  def ensure_correct_customer
    @customer = current_customer
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
