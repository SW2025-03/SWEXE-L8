class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:login_uid] = @user.id
      redirect_to root_path, notice: "🎉 登録が完了しました！ようこそ、#{@user.name}さん！"
    else
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
