FactoryGirl.define do
  factory :user do
    name 'Ralph Mueller'
    email 'ralph.mueller.de@gmail.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end