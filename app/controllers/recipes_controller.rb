class RecipesController < ApplicationController
  before_action :authenticate_user!
  def new
    @recipe = Recipe.new
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @foods = Food.where(user_id: current_user.id)
    if @recipe.save
      flash[:notice] = 'レシピ登録が完了しました'
      redirect_to menu_path(@recipe.menu)
    else
      flash[:alert] = '登録できませんでした'
      flash[:errors] = @recipe.errors.full_messages
      redirect_to new_recipe_path(menu_id: @recipe.menu_id)
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @foods = Food.where(user_id: current_user.id)
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_update)
      flash[:notice] = 'レシピを更新しました'
      redirect_to menu_path(@recipe.menu)
    else
      flash.now[:alert] = '更新できませんでした'
      render 'recipes/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = 'レシピを削除しました'
    redirect_to menu_path(@recipe.menu)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:gram, :user_id, :menu_id, :food_id)
  end

  def recipe_update
    params.require(:recipe).permit(:gram, :food_id)
  end
end
