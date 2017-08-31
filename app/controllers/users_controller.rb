class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy # Предфильтр открывающий доступ к действию destroy только админам.

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) # params для получения id пользователя
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create  # Метод обрабатывающий форму регитсрации пользователей
    @user = User.new(user_params) # Использование строгих параметровç
    if @user.save # true - если успешно сохранение
      sign_in @user  #  Вход пользователя сразу после регистрации
      flash[:success] = "Welcome to the Sample App!" # Добавление флеш сообщения к успешной регистрации пользователя.
      redirect_to @user # Переадресация на страницу показывающую пользователя
    else # Если валидация формы не прошла
      render 'new'
    end
  end

  def edit # Для страницы редактирования
    @user = User.find(params[:id])
  end

  def update # Для страницы редактирования
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) # user_params в вызове update_attributes - параметры для предотвращения уязвимости массового назначения
      flash[:success] = "Profile updated"
      redirect_to @user
    else # Провальное редактирование
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end




  private # user_params - будет использоваться только в нутри контроллера
  # Использование строгих параметров в действии create
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Добавление предфильтра signed_in_user.  Защита от не авторизованных пользователей
  def signed_in_user
    unless signed_in? # sessions_helper.rb
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  # Предфильтр correct_user для защиты edit/update pages
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) # метод current_user?, который мы определили в хелпере Sessions
   # current_user? - sessions_helper.rb
  end

  # Предфильтр открывающий доступ к действию destroy только админам.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
