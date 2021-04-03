class ItemsController < ApplicationController
  before_action :move_action, only: [:new, :create]

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
end

private

def item_params
  params.require(:item).permit(:image, :product_name, :description, :category_id, :status_id, :postage_id, :region_id, :shippingdate_id,
                               :selling_price).merge(user_id: current_user.id)
end

def move_action
  redirect_to new_user_session_path unless user_signed_in?
end
