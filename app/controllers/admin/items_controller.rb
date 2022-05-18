class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
     flash[:notice] = "商品を登録しました"
     redirect_to admin_item_path
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
     flash[:notice] = "商品情報を更新しました"
     redirect_to admin_item_path
  end

  private

    def item_params
      params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
    end

end