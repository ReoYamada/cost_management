class Food < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  validates :name, :unit_price_per_kilo, :user_id, presence: true
  validates :unit_price_per_kilo, numericality: { only_integer: true }
end
