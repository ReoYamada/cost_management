require 'rails_helper'

RSpec.describe 'Menus', type: :system do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }
  before do
    driven_by(:rack_test)
    sign_in user
    visit user_path(user)
  end

  describe 'メニュー登録テスト' do
    it 'メニュー登録をクリックしたとき登録画面にアクセスすること' do
      click_on 'メニュー登録'
      expect(current_path).to eq new_menu_path
    end

    describe 'メニュー登録画面テスト' do
      before do
        visit new_menu_path
      end

      context '入力内容が正常' do
        it 'メニュー登録が成功し、メニュー一覧ページに表示されること' do
          fill_in 'メニュー名', with: 'hoge'
          fill_in '価格', with: 500
          click_on '登録する'
          expect(page).to have_content 'メニュー登録が完了しました'
          expect(current_path).to eq menus_path
          expect(page).to have_content 'hoge'
          expect(page).to have_content '500'
        end
      end

      context 'メニュー名が未入力' do
        it 'メニュー名の未入力エラーメッセージが表示されること' do
          fill_in 'メニュー名', with: ''
          fill_in '価格', with: 500
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content 'メニュー名を入力してください'
        end
      end

      context 'メニュー価格が未入力' do
        it 'メニュー価格の未入力エラーメッセージが表示されること' do
          fill_in 'メニュー名', with: 'hoge'
          fill_in '価格', with: ''
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content '価格を入力してください'
        end
      end
    end
  end

  describe 'メニュー編集テスト' do
    it 'メニュー編集をクリックしたとき編集画面にアクセスすること' do
      visit menus_path
      click_on '編集'
      expect(current_path).to eq edit_menu_path(menu)
    end

    describe 'メニュー編集画面テスト' do
      before do
        visit edit_menu_path(menu)
      end

      it '編集内容に編集前のワードが入っていること' do
        expect(page).to have_field 'メニュー名', with: menu.name
        expect(page).to have_field '価格', with: menu.price
      end

      context '入力内容が正常' do
        it 'メニュー編集が成功し、メニュー一覧ページに表示されること' do
          fill_in 'メニュー名', with: 'hoge'
          fill_in '価格', with: 500
          click_on '更新する'
          expect(page).to have_content 'メニューを更新しました'
          expect(current_path).to eq menus_path
          expect(page).to have_content 'hoge'
          expect(page).to have_content '500'
        end
      end

      context 'メニュー名が未入力' do
        it 'メニュー名の未入力エラーメッセージが表示されること' do
          fill_in 'メニュー名', with: ''
          fill_in '価格', with: 500
          click_on '更新する'
          expect(page).to have_content '更新できませんでした'
          expect(page).to have_content 'メニュー名を入力してください'
        end
      end

      context 'メニュー価格が未入力' do
        it 'メニュー価格の未入力エラーメッセージが表示されること' do
          fill_in 'メニュー名', with: 'hoge'
          fill_in '価格', with: ''
          click_on '更新する'
          expect(page).to have_content '更新できませんでした'
          expect(page).to have_content '価格を入力してください'
        end
      end
    end
  end

  describe 'メニュー削除テスト' do
    before do
      visit menus_path
      click_on '削除'
    end

    it '削除後メッセージが表示されること' do
      expect(page).to have_content 'メニューを削除しました'
    end

    it '削除後メニューが表示されないこと' do
      expect(page).not_to have_content menu.name
    end
  end
end
