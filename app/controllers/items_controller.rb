class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :buy]
  before_action :set_item, only: [:show, :edit, :buy, :pay]
  before_action :item_params, only: [:create, :update]
  
  def index
    @items = Item.order('id DESC').limit(4)
  end
  
  def show
  end  

  def new
    @item = Item.new
    @item.item_photos.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      @parents = Category.all.order("id ASC").limit(13)
      render :new
    end
  end

  def edit

    @item = Item.find(params[:id])
    @parents = Category.all.order("id ASC").limit(13)
  
    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
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
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
    

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  
    # imageLength = 0
    # deleteImage = 0
    # params[:item][:images_attributes].each do |p|
    #   imageLength += 1
    # end
    # for num in 0..9
    #   if params[:item][:item_photos_attributes][num.to_s] != nil
    #     if params[:item][:imtem_photos_attributes][num.to_s][:_destroy] == "1"
    #       deleteImage += 1
    #     end
    #   end
    # end
    # if @item.valid? && !@item.item_photos.empty? && imageLength != deleteImage
    #   @item.update(item_params)
    # else
    #   redirect_to edit_item_path(@item)
    # end
  
  
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
    @parents  = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.where(ancestry: params[:parent_id])
  end

  def set_grandchildren
    @grandchildren = Category.where(ancestry: params[:ancestry])
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_item_photos
    @item_photos = ItemPhoto.where(item_id: params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :explain, :status_id, :category_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, :shipping_way_id, :price, item_photos_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

end
