class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :buy]
  before_action :set_item, only: [:show, :edit, :update, :buy, :pay]
  before_action :item_params, only: [:create, :update]
 
  
  def index
    @items = Item.order('id DESC').limit(4)
  end
  
  def new
    @item = Item.new
    @item.item_photos.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      @parents = Category.all.order("id ASC").limit(13)
      rnder new
    end
  end

  def show
  end


  def edit
    @parents = Category.all.order("id ASC").limit(13)
    if params[:parent]
      @child_categories = Category.where('ancestry = ?', "#{params[:parent]}")
    else
      @grandchild_categories = Category.where('ancestry LIKE ?', "%/#{params[:child]}")
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      edit_item_path(@product)
    end
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

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end

  def set_item_photos
    @item_photos = ItemPhoto.where(item_id: params[:id])
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :explain, :status_id, :category_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, :shipping_way_id, :price, :remove_image, item_photos_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

end
