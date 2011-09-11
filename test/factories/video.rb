FactoryGirl.define do
  factory :video do
    user
    title 'Test'
    state 'converted'
  end
  
  factory :converting, :class => Video do
    user
    title 'Test Converting'
    state 'converting'
  end
  
  factory :pending, :class => Video do
    user
    title 'Test Pending'
    state 'pending'
  end
end