class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user)
    @menus = Menu.where(user_id: current_user)
    @view = 'index'
  end

  def new
    @order = Order.new
    @menus = Menu.where(user_id: current_user)
  end

  def create
    @orders = orders_params
    is_break = false
    @orders.each do |orders|
      @order = Order.new(order_params)
      @order.user_id = orders[:user_id]
      @order.menu_id = orders[:menu_id]
      @order.output = orders[:output]
      unless @order.save
        is_break = true
        break
      end
    end
    if is_break
      flash[:alert] = '登録できませんでした'
      flash[:error] = @order.errors.full_messages
      redirect_to new_order_path
    else
      flash[:notice] = '出数登録が完了しました'
      redirect_to orders_path
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_update_params)
      flash[:notice] = '出数を更新しました'
      redirect_to orders_path
    else
      flash[:alert] = '更新できませんでした'
      redirect_to edit_order_path(params[:id])
    end
  end

  def search
    @menus = Menu.where(user_id: current_user)
    @orders = Order.where(user_id: current_user).day_search(params[:date])
    @view = 'search'
    render 'orders/index'
  end

  private

  def order_params
    params.require(:order).permit(:year_and_month)
  end

  def orders_params
    params.require(:orders).map do |orders|
      orders.permit(:user_id, :output, :menu_id)
    end
  end

  def order_update_params
    params.require(:order).permit(:output)
  end
end
