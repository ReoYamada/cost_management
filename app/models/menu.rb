class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes
  has_many :orders
  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true }
end
