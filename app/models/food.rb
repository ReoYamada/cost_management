class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes
  validates :name, :unit_price_per_kilo, presence: true
  validates :unit_price_per_kilo, numericality: { only_integer: true }
end
