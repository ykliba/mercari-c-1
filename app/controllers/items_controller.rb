class ItemsController < ApplicationController
  
  before_action :move_to_index, except: [:index, :show, :buy]
  before_action :set_item, only: [:show, :buy, :pay]
  
  def index
    @items = Item.order('id DESC').limit(4)
  end
  
  def show
  end

  def new
    @item = Item.new
    @item.item_images.build
    @item.build_shipping
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    end
  end

  def buy
  end
  
  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: @item.price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end

  def done
  end

  private
  
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :text,
      :price,
      #この辺の他コードは関係ない部分なので省略してます
    ).merge(user_id: current_user.id)
  end

end
