class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes
  has_many :orders
  validates :name, :price, :user_id, presence: true
  validates :price, numericality: { only_integer: true }

  def menu_cost
    cost = 0
    recipes.each do |recipe|
      cost += recipe.food.unit_price_per_kilo * recipe.gram
    end
    cost
  end
end
