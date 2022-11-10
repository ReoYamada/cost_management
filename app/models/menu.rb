class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes
  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true }
end
