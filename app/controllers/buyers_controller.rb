class BuyersController < ApplicationController
  require 'payjp'#Payjpの読み込み
  before_action :set_credit_card, :set_item

  def index
    if @credit_card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_credit_card_path
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP][:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@credit_card.customer_id) 
      #カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

  def pay
    Payjp.api_key = Rails.application.credentials[:PAYJP][:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
      :amount => @item.price, #支払金額を引っ張ってくる
      :customer => @credit_card.customer_id,  #顧客ID
      :currency => 'jpy',              #日本円
    )
    @item = Item.find(params[:item_id])
    @item.update_columns(buyer_id: current_user.id)
    redirect_to done_item_buyers_path #完了画面に移動
  end

  def done
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
