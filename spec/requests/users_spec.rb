require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  describe 'マイページ' do
    it '正常なレスポンスを返すこと' do
      sign_in user
      get users_path
      expect(response).to have_http_status(200)
    end
  end
end
