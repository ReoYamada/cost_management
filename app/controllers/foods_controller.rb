class FoodsController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = Food.where(user_id: current_user)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:notice] = '食材登録が完了しました'
      redirect_to foods_path
    else
      flash.now[:alert] = '登録できませんでした'
      render new_food_path, status: :unprocessable_entity
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      flash[:notice] = '食材情報を更新しました'
      redirect_to foods_path
    else
      flash.now[:alert] = '更新できませんでした'
      render 'foods/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:notice] = '食材情報を削除しました'
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :unit_price_per_kilo, :user_id)
  end
end
