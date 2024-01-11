# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :update_username]

  def edit
  end

  def new
    @user = User.new
  end

  def update
   if current_user.update(user_params)
     redirect_to root_path, notice: 'Настройки обновлены успешно.'
    else
     render :edit
    end
  end

  def update_username
    @user = current_user
    if @user.can_change_username?
      if @user.update(username: params[:user][:username], last_username_change: Time.now)
        redirect_to user_settings_path, notice: 'Имя пользователя успешно изменено.'
      else
        flash[:error] = 'Ошибка при изменении имени пользователя.'
        render :edit_username
      end
    else
      flash[:error] = 'Вы можете изменять имя пользователя только раз в 5 дней.'
      redirect_to user_settings_path
    end
  end

  def edit_username
    @user = current_user
  end

  def update_email
    @user = current_user
    if @user.can_change_email?
      if @user.update(user_params)
        flash[:notice] = 'Email успешно обновлен.'
      else
        flash[:alert] = 'Ошибка при обновлении email. Пожалуйста, проверьте введенные данные.'
      end
    else
      flash[:alert] = 'Вы можете изменять email только раз в 5 дней.'
    end
    redirect_to settings_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:digest_frequency, :username, :email)
  end
end
