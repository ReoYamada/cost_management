require 'rails_helper'

RSpec.describe Food, type: :model do
  let!(:user) { create(:user) }
  let(:food) { build(:food) }

  it '登録ユーザーが存在し商品名、商品単価があれば有効であること' do
    expect(food.valid?).to eq true
  end

  it '商品名が無ければ無効であること' do
    food.name = ''
    expect(food.valid?).to eq false
  end

  it '商品単価が無ければ無効であること' do
    food.unit_price_per_kilo = ''
    expect(food.valid?).to eq false
  end

  it '商品単価が文字列であれば無効であること' do
    food.unit_price_per_kilo = 'hoge'
    expect(food.valid?).to eq false
  end
end
