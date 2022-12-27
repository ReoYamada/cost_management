class ApplicationController < ActionController::Base
  # ログイン後のリダイレクト先
  def after_sign_in_path_for(_resource)
    users_path
  end
end
