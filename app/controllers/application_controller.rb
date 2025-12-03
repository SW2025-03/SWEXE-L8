class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # 現在ログインしているユーザーを返す
  def current_user
    # セッションに user_id があれば DB から取得
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしているかどうか
  def logged_in?
    current_user.present?
  end

  # ログイン必須アクションでリダイレクト
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
