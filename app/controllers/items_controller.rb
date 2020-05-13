class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :buy]
  before_action :set_item, only: [:show, :buy, :pay]

  def index
    @items = Item.order('id DESC').limit(4)
  end
  
  def new
    @item = Item.new
    @item.item_photos.new
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      render :new
    end
  end

  def show
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:PAYJP][:PAYJP_PRIVATE_KEY]
    charge = Payjp::Charge.create(
    amount: @item.price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end

  def done
  end

  

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  
  private

  def item_params
    params.require(:item).permit(:name, :explain, :status_id, :category_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, :shipping_way_id, :price,  brands_attributes: [:name],  item_photos_attributes: [:image])
  end
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  

end
