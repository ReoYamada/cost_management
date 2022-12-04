require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }
  let(:order) { create(:order) }
  let(:params) { { order: attributes_for(:order) } }
  let(:new_params) { { order: { year_and_month: '2022-11-15' }, orders: [{ user_id: 1, output: 1, menu_id: 1 }] } }
  before do
    sign_in user
  end

  describe 'オーダー一覧ページ' do
    it '正常なレスポンスを返すこと' do
      get orders_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'オーダー新規登録ページ' do
    it '正常なレスポンスを返すこと' do
      get new_order_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'オーダー新規登録' do
    it '正常なレスポンスを返すこと' do
      post orders_path, params: new_params
      expect(response).to have_http_status(302)
    end
  end

  describe 'オーダー編集ページ' do
    it '正常なレスポンスを返すこと' do
      get edit_order_path(order)
      expect(response).to have_http_status(200)
    end
  end

  describe 'オーダー編集' do
    it '正常なレスポンスを返すこと' do
      put order_path(order), params: params
      expect(response).to have_http_status(302)
    end
  end
end
