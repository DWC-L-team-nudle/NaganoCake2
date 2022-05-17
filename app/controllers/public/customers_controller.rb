class Public::CustomersController < ApplicationController
  # 今はバリデーションを無視して実装します
  # before_action :authenticate_costomer!
  # before_action :ensure_correct_costomer, only: [:edit, :update]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  private

  def costomer_params
    params.require(:costomer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_costomer
    @costomer = Costomer.find(params[:id])
    unless @costomer == current_costomer
      redirect_to costomer_path(current_costomer)
    end
  end
end
