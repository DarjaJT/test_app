require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # Тесты для модели User
  # before - Задаем тестовые данные
  before { @user = User.new(name: "Example User", email: "user@example.com",
                            password: "foobar", password_confirmation: "foobar") }
  # before - запускает код внутри блока перед каждым тестом

  subject { @user } # делает @user дефолтным cубъектом тестирования

  it { should respond_to(:id) } # Тест проверяет наличие поля в таблице по имени
  it { should respond_to(:name) } # Тест проверяет наличие поля в таблице по имени
  it { should respond_to(:email) } # Тест проверяет наличие поля в таблице по имени
  it { should respond_to(:password_digest) } # Проверка того, что объект User имеет столбец password_digest
  it { should respond_to(:password) } # Тестирование атрибутов password и password_confirmation
  it { should respond_to(:password_confirmation) }

  it { should be_valid } # проверка на то что объект @user изначально валиден
  it { should respond_to(:authenticate) } # объект User должен отвечать на authenticate

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
                               # следовательно, он   не должен быть валидным
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

  # # тест для валидации наличия пароля. Что бы пароли небыли пустыми
  # describe "when password is not present" do
  #   before { @user.password = @user.password_confirmation = " " } # пароль и его подтверждение равными чистой строке.
  #   it { should_not be_valid }
  # end

  # Тест для пароля и его подтверждения.
  describe "when password is not present" do
    before { @user = User.new(name: "Example User", email: "user@example.com", password: "", password_confirmation: "") }
    it { should_not be_valid }
  end

  # Тест на случай не совпадения паролей
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  # Тест на длинну паролей, не меньше 6 знаков
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  # Тесты для метода authenticate.
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) } #  let для получения пользователя из базы данных с помощью find_by
    # Блок before сохраняет пользователя в базе данных, так что он может быть получен с помощью find_by, чего мы достигаем используя let метода

    # Случай совпадения поролей
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) } # eq - равенство (==)
    end

    # Случай несовпадения паролей
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false } # метод specify. Это просто синоним для it,
                                                # который может быть использован когда it звучит ненатурально
    end
  end

  # Тест для кода отвечающего за перевод email в нижний регистр
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end




end
