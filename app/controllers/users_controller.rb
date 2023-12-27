# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

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

  #def create
    #@user = User.new(user_params)

   # respond_to do |format|
    #  if @user.save
    #    sign_in(@user) # Автоматически войти после успешной регистрации
    #    format.html { redirect_to root_path, notice: 'Пользователь успешно создан и вошел в систему.' }
    #  else
    #    format.html { render :new }
    #  end
   # end
 # end

  private

  def user_params
    params.require(:user).permit(:digest_frequency)
  end
end
