class UsersController < ApplicationController
  # マイページ
  def show
    @user = User.find(params[:id])
    @orders = Order.where(user_id: params[:id])
  end
end
