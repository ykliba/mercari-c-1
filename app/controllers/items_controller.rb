class ItemsController < ApplicationController
  
  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def new
    @item = Item.new
    @item.item_photos.new
    @category_parent_array = ["選択してください"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    # binding pry
    if @item.save
      redirect_to root_path
    else
      @category_parent_array = ["選択してください"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
     
      render :new
    end
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
  
end
