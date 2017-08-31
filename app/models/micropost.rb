class Micropost < ApplicationRecord
  belongs_to :user # Микросообщение пренадлежит пользователю.
  default_scope -> { order('created_at DESC') } # Упорядочивание микросообщений с default_scope
  validates :content, presence: true, length: { maximum: 140 } # Валидации модели Micropost.
  validates :user_id, presence: true # Валидация для user_id атрибута микросообщения.


  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

end
