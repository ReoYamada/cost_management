class Food < ApplicationRecord
  belongs_to :user
  validates :name, :unit_price_per_kilo, presence: true
end
