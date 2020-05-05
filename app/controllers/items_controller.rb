class ItemsController < ApplicationController
  
  before_action :move_to_index, except: [:index, :show, :buy]
  before_action :set_item, only: [:show, :buy]
  
  def index
    @items = Item.all
  end
  
  def show
  end

  def buy
  end
  
  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: 300,#決済金額の事。変数も使えるので後で解説
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
