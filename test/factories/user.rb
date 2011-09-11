FactoryGirl.define do
  factory :user do
    username 'johndoe'
    firstname 'John'
    name  'Doe'
    email 'johndoe@wedeltube.de'
    password 'test123'
    confirmed_at '2011-09-11 10:00:00'
    admin false
  end
  
  factory :unconfirmed, :class => User do
    username 'unconfirmed'
    firstname 'unconfirmed'
    name  'test'
    email 'unctest@wedeltube.de'
    password 'test123'
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, :class => User do
    username 'admin'
    firstname 'Admin'
    name  'User'
    email 'admin@wedeltube.de'
    admin true
  end
end