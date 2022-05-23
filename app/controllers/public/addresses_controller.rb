class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    customer = Customer.find_by(params[:customer_id])
    @addresses = customer.addresses
    @address_new = Address.new
  end

  def create
    @customer = Customer.find_by(params[:customer_id])
    @address_new = Address.new(address_params)
    @address_new.customer_id = @customer.id
    if @address_new.save
      flash[:notice] = "新しいお届け先を登録しました"
      redirect_to addresses_path(@customer.id)
    else
      @addresses = @customer.addresses
      render :index
    end
  end

  def edit
    @address= Address.find(params[:id])
    if @address.customer_id != current_customer.id
        redirect_to root_path
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送登録情報を更新しました"
      redirect_to addresses_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.delete
    flash[:notice] = "配送先の登録情報を削除しました"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
