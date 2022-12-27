class TopController < ApplicationController
  def index
    redirect_to users_path if current_user
  end

  def guest_sign_in
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.skip_confirmation!
    end
    sign_in guest_user
    redirect_to users_path, notice: 'ゲストとしてログインしました'
  end
end
