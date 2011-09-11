FactoryGirl.define do
  factory :video do
    user
    title 'Test'
    state 'converted'
    video File.new(Rails.root + 'spec/test_files/Frau.avi')
  end
  
  factory :converting, :class => Video do
    user
    title 'Test Converting'
    state 'converting'
    video File.new(Rails.root + 'spec/test_files/Frau.avi')
  end
  
  factory :pending, :class => Video do
    user
    title 'Test Pending'
    state 'pending'
    video File.new(Rails.root + 'spec/test_files/Frau.avi')
  end
end