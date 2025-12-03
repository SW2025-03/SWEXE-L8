class TopController < ApplicationController
  def main
  end

  def login
  end
  
  def create_session
    user = User.find_by(name: params[:name])
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "ログインしました"
    else
      flash.now[:alert] = "名前またはパスワードが間違っています"
      render :login, status: :unprocessable_entity
    end
  end
  
  def logout
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました"
  end
end
