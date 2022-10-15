require 'rails_helper'

RSpec.describe 'Top', type: :request do
  describe 'GET /' do
    it '正常にレスポンスを返すこと' do
      get '/'
      expect(response).to have_http_status(200)
    end
  end
end
