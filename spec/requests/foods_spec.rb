require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  let!(:user) { create(:user) }
  let(:food) { create(:food) }
  let(:params) { { food: attributes_for(:food) } }
  before do
    sign_in user
  end

  describe '食材一覧ページ' do
    it '正常なレスポンスを返すこと' do
      get foods_path
      expect(response).to have_http_status(200)
    end
  end

  describe '食材登録ページ' do
    it '正常なレスポンスを返すこと' do
      get new_food_path
      expect(response).to have_http_status(200)
    end
  end

  describe '食材登録' do
    it '正常なレスポンスを返すこと' do
      post foods_path, params: params
      expect(response).to have_http_status(302)
    end
  end

  describe '食材編集ページ' do
    before do
      get edit_food_path(food)
    end

    it '正常なレスポンスを返すこと' do
      expect(response).to have_http_status(200)
    end

    it '編集食材名を取得できること' do
      expect(response.body).to include food.name
    end

    it '編集食材単価を取得できること' do
      expect(response.body).to include food.unit_price_per_kilo.to_s
    end
  end

  describe '食材編集' do
    it '正常なレスポンスを返すこと' do
      put food_path(food), params: params
      expect(response).to have_http_status(302)
    end
  end

  describe '食材削除' do
    it '正常なレスポンスを返すこと' do
      delete food_path(food)
      expect(response).to have_http_status(302)
    end
  end
end
