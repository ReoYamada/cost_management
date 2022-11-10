require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let!(:user) { create(:user) }
  let!(:food) { create(:food) }
  let!(:menu) { create(:menu) }
  let(:recipe) { create(:recipe) }
  let(:params) { { recipe: attributes_for(:recipe) } }
  before do
    sign_in user
  end

  describe 'レシピ新規登録ページ' do
    it '正常なレスポンスを返すこと' do
      get new_recipe_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'レシピ新規登録' do
    it '正常なレスポンスを返すこと' do
      post recipes_path, params: params
      expect(response).to have_http_status(302)
    end
  end

  describe 'レシピ編集ページ' do
    it '正常なレスポンスを返すこと' do
      get edit_recipe_path(recipe)
      expect(response).to have_http_status(200)
    end
  end

  describe 'レシピ編集' do
    it '正常なレスポンスを返すこと' do
      put recipe_path(recipe), params: params
      expect(response).to have_http_status(302)
    end
  end

  describe 'レシピ削除' do
    it '正常なレスポンスを返すこと' do
      delete recipe_path(recipe)
      expect(response).to have_http_status(302)
    end
  end
end
