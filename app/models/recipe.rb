class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  belongs_to :food
  validates :gram, :user_id, presence: true
  validates :gram, numericality: { only_integer: true }
  validates :food_id, uniqueness: { scope: :menu_id }
end
