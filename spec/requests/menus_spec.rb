require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  let!(:user) { create(:user) }
  let(:menu) { create(:menu) }
  let(:params) { { menu: attributes_for(:menu) } }
  before do
    sign_in user
  end

  describe 'メニュー一覧ページ' do
    it '正常なレスポンスを返すこと' do
      get menus_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'メニュー登録ページ' do
    it '正常なレスポンスを返すこと' do
      get new_menu_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'メニュー登録' do
    it '正常なレスポンスを返すこと' do
      post menus_path, params: params
      expect(response).to have_http_status(302)
    end
  end

  describe 'メニュー詳細' do
    before do
      get menu_path(menu)
    end

    it '正常なレスポンスを返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'メニュー名を取得できること' do
      expect(response.body).to include menu.name
    end

    it 'メニュー価格を取得できること' do
      expect(response.body).to include menu.price.to_s
    end
  end

  describe 'メニュー編集ページ' do
    before do
      get edit_menu_path(menu)
    end

    it '正常なレスポンスを返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'メニュー名を取得できること' do
      expect(response.body).to include menu.name
    end

    it 'メニュー価格を取得できること' do
      expect(response.body).to include menu.price.to_s
    end
  end

  describe 'メニュー編集' do
    it '正常なレスポンスを返すこと' do
      put menu_path(menu), params: params
      expect(response).to have_http_status(302)
    end
  end

  describe 'メニュー削除' do
    it '正常なレスポンスを返すこと' do
      delete menu_path(menu)
      expect(response).to have_http_status(302)
    end
  end
end
