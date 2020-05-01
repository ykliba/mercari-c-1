# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @personal_righting = @user.build_personal_righting
    render :new_personal_righting
  end

  def create_next
    @user = User.new(session["devise.regist_data"]["user"])
    @personal_righting = PersonalRighting.new(personal_righting_params)
    unless @personal_righting.valid?
      flash.now[:alert] = @personal_righting.errors.full_messages
      render :new_personal_righting and return
    end
    @user.build_personal_righting(@personal_righting.attributes)
    session["devise.regist_data"]["personal_righting"] = @personal_righting.attributes
    @delivery_address = @user.delivery_addresses.new
    render :new_delivery_address
  end

  def create_information
    @user = User.new(session["devise.regist_data"]["user"])
    @user.build_personal_righting(session["devise.regist_data"]["personal_righting"])
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    unless @delivery_address.valid?
      flash.now[:alert] = @delivery_address.errors.full_messages
      render :new_delivery_address and return
    end
    @user.delivery_addresses.new(@delivery_address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end
  
  protected
  
  def personal_righting_params
    params.require(:personal_righting).permit(:firstname, :lastname, :firstname_hiragana, :lastname_hiragana, :birthday)
  end

  def delivery_address_params
    params.require(:delivery_address).permit(:delivery_firstname, :delivery_lastname, :delivery_firstname_hiragana, :delivery_lastname_hiragana, :postal_code, :prefecture, :city, :address, :room_number, :phone_number)
  end
end
