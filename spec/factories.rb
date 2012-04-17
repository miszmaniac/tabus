FactoryGirl.define do
  factory :user do
    name     "User test"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end