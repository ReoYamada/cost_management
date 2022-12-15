class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :name, :price, :user_id, presence: true
  validates :price, numericality: { only_integer: true }

  # メニューの原価を計算する機能
  def menu_cost
    cost = 0
    recipes.each do |recipe|
      cost += recipe.food.unit_price_per_kilo * recipe.gram
    end
    cost
  end
end
