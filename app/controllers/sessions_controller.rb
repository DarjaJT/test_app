class SessionsController < ApplicationController

  def new # Форма входа на сайт
  end

  def create # Сам вход на сайт
    # обработке неверного ввода
    # render 'new' # рендеринга представления new.
    user = User.find_by(email: params[:session][:email].downcase) # вытягивает пользователя из базы данных с помощью предоставленного адреса электронной почты
    # email адреса сохраняются в нижнем регистре, поэтому здесь мы используем метод downcase для обеспечения соответствия когда предоставленный адрес валиден
    if user && user.authenticate(params[:session][:password]) # authenticate возвращает false для невалидной аутентификации
     # && (логическое и) для определения валидности полученного пользователя.
      # Убработка удачного входа
      sign_in user # после успешного входа, мы впускаем пользователя, используя функцию sign_in
      redirect_to user # затем перенаправляем его на страницу профиля
    else
      # Обработка неудачного входа
      # рендеринг с флеш сообщением
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy # Выход из сайт
  end


end
