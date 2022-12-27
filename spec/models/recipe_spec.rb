require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }
  let!(:food) { create(:food) }
  let(:recipe) { build(:recipe) }

  it '登録ユーザーが存在し、登録メニュー、登録食材、グラム数があれば有効であること' do
    expect(recipe.valid?).to eq true
  end

  it 'グラム数が無ければ無効であること' do
    recipe.gram = ''
    expect(recipe.valid?).to eq false
  end

  it 'グラム数が文字列であれば無効であること' do
    recipe.gram = 'hoge'
    expect(recipe.valid?).to eq false
  end

  it '登録メニューが無ければ無効であること' do
    recipe.menu_id = nil
    expect(recipe.valid?).to eq false
  end

  it '登録食材が無ければ無効であること' do
    recipe.food_id = nil
    expect(recipe.valid?).to eq false
  end
end
