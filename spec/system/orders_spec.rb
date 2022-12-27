require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let!(:user) { create(:user) }
  let!(:menu) { create(:menu) }
  let!(:order) { create(:order) }
  before do
    driven_by(:rack_test)
    sign_in user
    visit users_path
  end

  it '月間出数管理をクリックしたとき管理画面にアクセスすること' do
    click_on '月間出数管理'
    expect(current_path).to eq orders_path
  end

  describe '月間出数登録テスト' do
    it '月間出数新規登録をクリックしたとき、登録画面にアクセスすること' do
      visit orders_path
      click_on '月間出数新規登録'
      expect(current_path).to eq new_order_path
    end

    describe '月間出数登録画面テスト' do
      before do
        visit new_order_path
      end

      context '入力内容が正常' do
        it '出数登録が成功し、管理ページにアクセスすること' do
          expect do
            fill_in menu.name, with: 50
            select '2022', from: 'order_year_and_month_1i'
            select '1月', from: 'order_year_and_month_2i'
            click_on '登録する'
            expect(page).to have_content '出数登録が完了しました'
            expect(current_path).to eq orders_path
          end.to change { Order.count }.by(1)
        end
      end

      context '出数が未入力' do
        it '出数の未入力エラーメッセージが表示されること' do
          fill_in menu.name, with: ''
          select '2022', from: 'order_year_and_month_1i'
          select '1月', from: 'order_year_and_month_2i'
          click_on '登録する'
          expect(page).to have_content '登録できませんでした'
          expect(page).to have_content '出数を入力してください'
        end
      end
    end
  end

  describe '月間出数編集テスト' do
    before do
      visit edit_order_path(order)
    end

    context '入力内容が正常' do
      it '出数編集が成功し、管理ページにアクセスすること' do
        fill_in '出数', with: 100
        click_on '更新する'
        expect(page).to have_content '出数を更新しました'
        expect(current_path).to eq orders_path
      end
    end

    context '出数が未入力' do
      it '出数の未入力エラーメッセージが表示されること' do
        fill_in '出数', with: ''
        click_on '更新する'
        expect(page).to have_content '更新できませんでした'
        expect(page).to have_content '出数を入力してください'
      end
    end
  end

  describe '月別出数表示テスト' do
    before do
      visit orders_path
      select '2022', from: 'date_year_and_month_1i'
      select '11月', from: 'date_year_and_month_2i'
      click_on '表示する'
    end

    it '年月を選択し表示するをクリックすると選択年月が表示されること' do
      expect(page).to have_content '2022年11月'
    end

    it '年月を選択し表示するをクリックすると月間出数が表示されること' do
      expect(page).to have_content order.output
    end
  end
end
