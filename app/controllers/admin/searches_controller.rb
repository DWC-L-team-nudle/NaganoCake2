class Admin::SearchesController < ApplicationController
  def search
    if params[:word].present?
      @items = Item.where('name LIKE ?', "%#{params[:word]}%").page(params[:page]).per(10)
    end
  end
end
