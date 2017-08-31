module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token # Устанавливаем куки
    # cookies - позволяет нам манипулировать куками браузера как если бы они были хэшем
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # update_attribute - этот метод позволяет обновлять один атрибут в обход валидаций — в данном
    # случае это необходимо так как у нас нет пароля пользователя.
    self.current_user = user # этот код никогда не будет использоваться в данном приложении из-за немедленного редиректа
  end

  def signed_in?
    !current_user.nil? # пользователь является вошедшим если current_user является не nil
  end

  def current_user=(user) # current_user= специально разработанного для обработки назначения current_user
    @current_user = user # переменную экземпляра @current_user, эффективно хранящую пользователя для дальнейшего использования
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token) # Поиск текущего пользователя с помощью remember_token
    # метод find_by при первом вызове которого вызывается current_user, но при последующих вызовах
    # возвращается @current_user без обращения к базе данных
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out # Метод выхода из сайта
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Код реализующий дружественную переадресацию.
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # Метод store_location помещает запрашиваемый URL в переменную session под ключом :return_to, но
  # только для GET запроса (if request.get?). Это предотвращает сохранение URL для перенаправления
  def store_location
    session[:return_to] = request.url if request.get?
  end


end
