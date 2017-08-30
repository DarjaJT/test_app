require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :feature do

  subject { page }

  # Тесты для new session действия и представления. Вход на сайт
  describe "signin page" do
    before { visit signin_path } # Определение маршрута для входа на сайт (routes.rb , sessions_controller.rb)

    it { should have_content('Sign in') } # view/sessions/new.html.erb
    it { should have_title('Sign in') } # view/sessions/new.html.erb

    # Тесты для провального входа.
    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') } # рендерить ошибку как флэш сообщение

      # Тест проверяющий неисчезающий флэш
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    #  Тесты успешного входа.
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase # upcase - для того чтобы быть уверенными в том что наша способность находить пользователя в базе данных не зависит от регистра
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) } # have_link - Он принимает в качестве аргументов текст ссылки и необязательный параметр :href
      # убеждается в том что якорный тег a имеет правильный атрибут href (URL) — в данном случае, ссылку на страницу профиля пользователя.
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      # Тест выхода пользователя.
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end

    end

  end



end
