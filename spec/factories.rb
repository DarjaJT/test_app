FactoryGirl.define do
  factory :user do # последующее определение предназначено для объекта модели User
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end