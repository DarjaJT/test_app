require 'rails_helper'
require 'support/utilities'

RSpec.describe "UserPages", type: :feature do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
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
