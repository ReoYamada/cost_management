class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(current_user.id)
    @orders = Order.where(user_id: current_user.id)
    @view = 'index'
  end

  def search
    @orders = Order.where(user_id: current_user).day_search(params[:date])
    @view = 'search'
    render 'users/index'
  end
end
