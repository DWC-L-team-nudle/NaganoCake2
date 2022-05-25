class Admin::SearchesController < ApplicationController
  def search
    @word = params[:word]
    if params[:word].present?
      @items = Item.where('name LIKE ?', "%#{params[:word]}%").page(params[:page]).per(10)
    else
      @items = Item.all.page(params[:page]).per(10)
    end
  end
end
