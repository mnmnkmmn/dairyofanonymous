class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def dairies
    @current_user_dairies = current_user.dairies.order(id: "DESC")
  end

  def fav
    favorite_dairy_id = Favorite.where(user_id: current_user.id).pluck(:dairy_id)
    @favorite_dairies = Dairy.find(favorite_dairy_id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_url, notice: "ユーザーを登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "ユーザーを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to login_url, notice: "ユーザーを削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
