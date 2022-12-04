require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  let!(:user) { create(:user) }
  let!(:food) { create(:food) }
  let!(:food2) { create(:food, name: '醤油') }
  let!(:menu) { create(:menu) }
  let!(:recipe) { create(:recipe) }
  before do
    driven_by(:rack_test)
    sign_in user
    visit menu_path(menu)
  end

  describe 'レシピ登録テスト' do
    before do
      click_on 'レシピ登録'
    end

    it 'レシピ登録をクリックしたときレシピ登録画面にアクセスすること' do
      expect(current_path).to eq new_recipe_path
    end

    describe 'レシピ登録画面テスト' do
      context '入力内容が正常' do
        it 'レシピの登録が成功し、メニュー詳細ページに表示されること' do
          select food2.name, from: '食材'
          fill_in 'グラム数', with: 50
          click_on '登録する'
          expect(page).to have_content 'レシピ登録が完了しました'
        end
      end

      context '食材名が未入力' do
        it '食材名の未入力エラーメッセージが表示されること' do
          select '食材を選択してください', from: '食材'
          fill_in 'グラム数', with: 50
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content '食材を入力してください'
        end
      end

      context 'グラム数が未入力' do
        it 'グラム数の未入力エラーメッセージが表示されること' do
          select food2.name, from: '食材'
          fill_in 'グラム数', with: ''
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content 'グラム数を入力してください'
        end
      end
    end
  end

  describe 'レシピ編集テスト' do
    before do
      click_on '編集'
    end

    it 'レシピの編集ボタンをクリックしたときレシピ編集ページにアクセスすること' do
      expect(current_path).to eq edit_recipe_path(recipe)
    end

    describe 'レシピ編集ページテスト' do
      context '入力内容が正常' do
        it 'レシピの登録が成功し、メニュー詳細ページに表示されること' do
          fill_in 'グラム数', with: 50
          click_on '更新する'
          expect(page).to have_content 'レシピを更新しました'
          expect(current_path).to eq menu_path(menu)
          expect(page).to have_content '50'
        end
      end

      context 'グラム数が未入力' do
        it 'グラム数の未入力エラーメッセージが表示されること' do
          fill_in 'グラム数', with: ''
          click_on '更新する'
          expect(page).to have_content '更新できませんでした'
          expect(page).to have_content 'グラム数を入力してください'
        end
      end
    end
  end

  describe 'レシピ削除テスト' do
    before do
      click_on '削除'
    end

    it '削除後メッセージが表示されること' do
      expect(page).to have_content 'レシピを削除しました'
    end

    it '削除後レシピが表示されないこと' do
      expect(page).not_to have_content food.name
    end
  end
end
