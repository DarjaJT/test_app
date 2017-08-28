class User < ApplicationRecord
  # Валидация наличия name атрибута. Чтобы при добавлении записи name не был пустым , Валидация длинны
  validates :name, presence: true, length: { maximum: 50 }
  # Валидация емаила. обеспечивает допустимость адресов электронной почты соответствующих образцу,
  # все остальные будут считаться недопустимыми.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

end
