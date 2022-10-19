require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:same_email_user) { build(:user, email: user.email) }

  it 'メールアドレス、パスワードがあれば有効な状態であること' do
    expect(user).to be_valid
  end

  describe 'パスワードテスト' do
    it 'パスワードが無ければ無効な状態であること' do
      user.password = nil
      expect(user.valid?).to eq false
    end

    it 'パスワードが６桁以下だと無効な状態であること' do
      user.password = '12345'
      expect(user.valid?).to eq false
    end
  end

  describe 'メールアドレステスト' do
    it 'メールアドレスが無ければ無効な状態であること' do
      user.email = nil
      expect(user.valid?).to eq false
    end

    it 'メールアドレスが重複する場合無効な状態であること' do
      user.save
      expect(same_email_user.valid?).to eq false
    end
  end
end
