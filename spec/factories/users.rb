FactoryGirl.define do
  factory :user do
    full_name "Joe Java"
    email "joe@java.com"
    password "password"
    password_confirmation "password"
  end
end
