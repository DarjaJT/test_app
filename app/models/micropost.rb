class Micropost < ApplicationRecord
  belongs_to :user # Микросообщение пренадлежит пользователю.

  default_scope -> { order('created_at DESC') } # Упорядочивание микросообщений с default_scope
  validates :content, presence: true, length: { maximum: 140 } # Валидации модели Micropost.
  validates :user_id, presence: true # Валидация для user_id атрибута микросообщения.
end
