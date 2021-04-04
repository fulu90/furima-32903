class ItemsController < ApplicationController
  before_action :move_action, only: [:new, :create, :edit, :update]
  before_action :redirect_root, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at ASC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :status_id, :postage_id, :region_id, :shippingdate_id,
                                 :selling_price).merge(user_id: current_user.id)
  end

  def move_action
    redirect_to new_user_session_path unless user_signed_in?
  end

  def redirect_root
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
