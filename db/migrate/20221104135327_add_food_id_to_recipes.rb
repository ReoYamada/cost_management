class AddFoodIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :food_id, :integer
  end
end
