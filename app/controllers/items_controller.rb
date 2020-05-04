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
  
  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
