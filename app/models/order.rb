class Order < ApplicationRecord
  belongs_to :menu
  validates :output, :year_and_month, :user_id, presence: true
  validates :output, numericality: { only_integer: true }
  validates :year_and_month, uniqueness: { scope: :menu_id }

  # 日付検索機能
  def self.day_search(day)
    where(year_and_month: day.values.join('-'))
  end

  # メニューの出数の合計値を返す機能
  def self.output_sum(menu)
    where(menu_id: menu).sum(:output)
  end

  # メニューの構成比を返す機能
  def self.occupancy(menu)
    menu_sum = 0
    all_sum = 0
    where(menu_id: menu).each do |order|
      menu_sum += order.menu.price * order.output
    end
    all.each do |order|
      all_sum += order.menu.price * order.output
    end
    (menu_sum / all_sum.to_f * 100).round(2)
  end
end
