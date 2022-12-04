require 'rails_helper'

RSpec.describe Menu, type: :model do
  let!(:user) { create(:user) }
  let(:menu) { build(:menu) }

  it '登録ユーザーが存在し、メニュー名、価格があれば有効であること' do
    expect(menu.valid?).to eq true
  end

  it 'メニュー名が無ければ無効であること' do
    menu.name = ''
    expect(menu.valid?).to eq false
  end

  it '価格が無ければ無効であること' do
    menu.price = ''
    expect(menu.valid?).to eq false
  end

  it '価格が文字列であれば無効であること' do
    menu.price = 'hoge'
    expect(menu.valid?).to eq false
  end
end
