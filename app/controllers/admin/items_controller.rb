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
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を登録しました"
      redirect_to admin_item_path(@item.id)
    else
      render "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました"
      redirect_to admin_item_path(@item.id)
    else
      render "edit"
    end
  end

  private

    def item_params
      params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
    end

end