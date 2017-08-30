class User < ApplicationRecord
  # before_save { self.email = email.downcase } # в нижний регистр email атрибут перед сохранением пользователя в базу данных
  # has_secure_password
  before_save { self.email = email.downcase } # Альтернативная реализация before_save.
  before_create :create_remember_token # метод обратного вызова для создания remember token
  # before_save { email.downcase! } # Альтернативная реализация before_save.

  # Код передает блок в коллбэк before_save и назначает email адрес пользователя равным его текущему значению
  # в нижнем регистре с помощью метода строки downcase

  # Валидация наличия name атрибута. Чтобы при добавлении записи name не был пустым , Валидация длинны
  validates :name, presence: true, length: { maximum: 50 }
  # Валидация емаила. обеспечивает допустимость адресов электронной почты соответствующих образцу,
  # все остальные будут считаться недопустимыми.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false } # Валидация уникальности адресов электронной почты
                                                  # Что бы пройти тест :uniqueness должно быть true.

  has_secure_password # Код необходимый для прохождения начальных тестов пароля.
  validates :password, length: { minimum: 6 } # минимальная длинна пароля 6 знаков

  def User.new_remember_token
    SecureRandom.urlsafe_base64 # шифрованная строка
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s) # мы шифровали токен с помощью SHA1 - хэширующего алгоритма
  end

  private # Все методы, определенные в классе после private автоматически становятся скрытыми

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
    # Использование self обеспечивает установку назначением пользовательского remember_token таким образом,
    # что он будет записан в базу данных вместе с другими атрибутами при сохранении пользователя.
  end

end
