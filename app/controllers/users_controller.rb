class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @orders = Order.where(user_id: params[:id])
    @view = 'index'
  end

  def search
    @orders = Order.where(user_id: current_user).day_search(params[:date])
    @view = 'search'
    render 'users/show'
  end
end
