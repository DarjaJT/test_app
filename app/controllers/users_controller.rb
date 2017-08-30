class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # params для получения id пользователя
  end

  def create  # Метод обрабатывающий форму регитсрации пользователей
    @user = User.new(user_params) # Использование строгих параметровç
    if @user.save # true - если успешно сохранение
      flash[:success] = "Welcome to the Sample App!" # Добавление флеш сообщения к успешной регистрации пользователя.
      redirect_to @user # Переадресация на страницу показывающую пользователя
    else # Если валидация формы не прошла
      render 'new'
    end
  end

  private # user_params - будет использоваться только в нутри контроллера
  # Использование строгих параметров в действии create
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
