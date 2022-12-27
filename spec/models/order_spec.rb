require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }
  let(:order) { build(:order) }

  it '登録ユーザーが存在し、年月、出数があれば有効であること' do
    expect(order.valid?).to eq true
  end

  it '年月が無ければ無効であること' do
    order.year_and_month = ''
    expect(order.valid?).to eq false
  end

  it '年月が文字列のとき無効であること' do
    order.year_and_month = 'hoge'
    expect(order.valid?).to eq false
  end

  it '出数が無ければ無効であること' do
    order.output = ''
    expect(order.valid?).to eq false
  end

  it '出数が文字列のとき無効であること' do
    order.output = 'hoge'
    expect(order.valid?).to eq false
  end
end
