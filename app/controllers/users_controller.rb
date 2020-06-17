class UsersController < ApplicationController
  # need security



  def show; end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end