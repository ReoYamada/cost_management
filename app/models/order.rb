class Order < ApplicationRecord
  belongs_to :menu
  validates :output, :year_and_month, presence: true
  validates :output, numericality: { only_integer: true }
  validates :year_and_month, uniqueness: { scope: :menu_id }

  def self.day_search(day)
    Order.where(year_and_month: day.values.join('-'))
  end
end
