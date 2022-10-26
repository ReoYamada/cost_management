require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  let!(:user) { create(:user) }
  let!(:food) { create(:food) }
  before do
    driven_by(:rack_test)
    sign_in user
    visit user_path(user)
  end

  describe '商品登録テスト' do
    it '食材登録をクリックしたとき登録画面にアクセスすること' do
      click_on '食材登録'
      expect(current_path).to eq new_food_path
    end

    describe '食材登録画面テスト' do
      before do
        visit new_food_path
      end

      context '入力内容が正常' do
        it '食材の新規登録が成功し、食材一覧ページに表示されること' do
          fill_in '食材名', with: 'hoge'
          fill_in 'キログラム単価', with: 100
          click_on '登録する'
          expect(page).to have_content '食材登録が完了しました'
          expect(current_path).to eq foods_path
          expect(page).to have_content 'hoge'
          expect(page).to have_content '100'
        end
      end

      context '食材名が未入力' do
        it '食材の新規登録が失敗すること' do
          fill_in '食材名', with: ''
          fill_in 'キログラム単価', with: 100
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(current_path).to eq new_food_path
        end
      end

      context '食材単価が未入力' do
        it '食材の新規登録が失敗すること' do
          fill_in '食材名', with: 'hoge'
          fill_in 'キログラム単価', with: ''
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(current_path).to eq new_food_path
        end
      end
    end
  end

  describe '食材一覧ページテスト' do
    it '食材一覧をクリックしたとき商品一覧ページにアクセスすること' do
      click_on '食材一覧'
      expect(current_path).to eq foods_path
    end

    describe '食材編集テスト' do
      before do
        visit foods_path
      end

      it '食材の編集ボタンをクリックしたとき食材編集ページにアクセスすること' do
        click_on '編集'
        expect(current_path).to eq edit_food_path(food)
      end

      describe '食材編集ページテスト' do
        before do
          visit edit_food_path(food)
        end

        it '入力内容に編集前のワードが入っていること' do
          expect(page).to have_field '食材名', with: food.name
          expect(page).to have_field 'キログラム単価', with: food.unit_price_per_kilo
        end

        context '入力内容が正常' do
          it '食材の新規登録が成功し、食材一覧ページに表示されること' do
            fill_in '食材名', with: 'hoge'
            fill_in 'キログラム単価', with: 100
            click_on '更新する'
            expect(page).to have_content '食材情報を更新しました'
            expect(current_path).to eq foods_path
            expect(page).to have_content 'hoge'
            expect(page).to have_content '100'
          end
        end

        context '食材名が未入力' do
          it '食材の新規登録が失敗すること' do
            fill_in '食材名', with: ''
            fill_in 'キログラム単価', with: 100
            click_on '更新する'
            expect(page).to have_content '更新できませんでした'
            expect(current_path).to eq edit_food_path(food)
          end
        end

        context '食材単価が未入力' do
          it '食材の新規登録が失敗すること' do
            fill_in '食材名', with: 'hoge'
            fill_in 'キログラム単価', with: ''
            click_on '更新する'
            expect(page).to have_content '更新できませんでした'
            expect(current_path).to eq edit_food_path(food)
          end
        end
      end
    end

    describe '食材削除テスト' do
      before do
        visit foods_path
        click_on '削除'
      end

      it '削除後のメッセージが表示されること' do
        expect(page).to have_content '食材情報を削除しました'
      end

      it '削除後食材が表示されないこと' do
        expect(page).not_to have_content food.name
      end
    end
  end
end
