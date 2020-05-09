class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
   end

   def erase
   end

   def done
   end

   private

end
