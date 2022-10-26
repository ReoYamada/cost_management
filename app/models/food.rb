class Food < ApplicationRecord
  belongs_to :user
  validates :name, :unit_price_per_kilo, presence: true
  validates :unit_price_per_kilo, numericality: { only_integer: true }
end
