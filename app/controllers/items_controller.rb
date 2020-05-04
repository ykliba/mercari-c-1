class ItemsController < ApplicationController
  
  before_action :move_to_index, except: [:index, :show, :buy]
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def buy
    @item = Item.find(params[:id])
  end
  
  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
