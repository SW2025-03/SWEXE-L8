class TopController < ApplicationController
  def main
  end

  def login
  end
  
  def create_session
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスかパスワードが違います"
      render :login, status: :unprocessable_entity
    end
  end
  
  def logout
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました"
  end
end
