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
    if @item.save
       redirect_to admin_item_path(@item.id)
    else
       @genres = Genre.all
       render "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to admin_item_path(@item)
    else
       render :edit
    end
  end
  
  def destroy
    item = Item.find(params[:id])
    item.delete
     redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :genre_id, :name, :introduction, :price, :is_active)
  end

end