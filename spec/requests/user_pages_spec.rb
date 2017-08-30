require 'rails_helper'
require 'support/utilities'

RSpec.describe "UserPages", type: :feature do
  subject { page }

  # базовые тесты для регистрации пользователей
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      # Тестирование того, что вновь зарегистрированные пользователи также являются вошедшими.
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

    end

  end

  # чтобы протестировать страницу показывающую пользователя
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) } # создать фабрику User
    # Replace with code to make a user variable
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end




end
