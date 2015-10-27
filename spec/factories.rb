FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password 'foobar'
    password_confirmation 'foobar'
    roles_mask 2
    state 'active'

    factory :admin do
      roles_mask 1
    end
  end
end
