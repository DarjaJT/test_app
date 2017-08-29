require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Тесты для модели User
  before { @user = User.new(name: "Example User", email: "user@example.com") }
  # before - запускает код внутри блока перед каждым тестом

  subject { @user } # делает @user дефолтным cубъектом тестирования

  # Два теста в Листинге 6.5 тестируют на наличие name и email атрибутов:
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid } # проверка на то что объект @user изначально валиден

  it { should respond_to(:id) } # Тест проверяет наличие поля в таблице по имени
  it { should respond_to(:name) } # Тест проверяет наличие поля в таблице по имени
  it { should respond_to(:email) } # Тест проверяет наличие поля в таблице по имени

  describe "when name is not present" do # Тест на наличие атрибута (Поле не долно быть пустым)
    before { @user.name = " " } # назначает пользовательскому имени недопустимое значение,
    it { should_not be_valid } # затем проверяет что получившийся объект @user невалиден
  end

  describe "when email is not present" do # Тест на наличие атрибута (Поле не долно быть пустым)
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do # Тест для валидации длины (Max 50 символов)
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  # Тесты для валидации формата адреса электронной почты
  # верхний регистр, подчеркивание и соединенные домены
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  # Тест на отклонение повторяющихся адресов электронной почты.
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup # оздании пользователя с тем же адресом электронной почты, что и у @user
      # @user.dup, который создает дубликат пользователя с теми же атрибутами
      user_with_same_email.save # затем сохраняем этого пользователя
    end
    it { should_not be_valid } #  @user будет иметь адрес электронной почты который уже существует в базе данных и,
                               # следовательно, он не должен быть валидным
  end
  # тест на отклонение дублирующихся адресов электронной почты.
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase # upcase метод на строках (Прописными буквами)
      user_with_same_email.save
    end
    it { should_not be_valid }
  end




end
