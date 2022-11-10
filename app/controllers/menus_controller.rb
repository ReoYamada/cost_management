class MenusController < ApplicationController
  def index
    @menus = Menu.where(user_id: current_user)
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      flash[:notice] = 'メニュー登録が完了しました'
      redirect_to menus_path
    else
      flash[:alert] = '登録できませんでした'
      redirect_to new_menu_path
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      flash[:notice] = 'メニューを更新しました'
      redirect_to menus_path
    else
      flash[:alert] = '更新できませんでした'
      redirect_to edit_menu_path(params[:id])
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    flash[:notice] = 'メニューを削除しました'
    redirect_to menus_path
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :price, :user_id)
  end
end
