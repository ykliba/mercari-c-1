class UsersController < ApplicationController
  def show
    @user = User.where(id: current_user.id)
  end

  def erase
  end

  def done
  end

end
