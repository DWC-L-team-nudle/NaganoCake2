class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    if params[:word].present?
      @items = Item.where('name LIKE ?', "%#{params[:word]}%").page(params[:page]).per(9)
    end
  end
end
