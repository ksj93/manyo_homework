FactoryBot.define do
  factory :user do
    name { "AA" }
    email { "aa@test.com" }
    password { "123456" }
    authority {0}
  end
  factory :user_second, class:User do
    name { "BB" }
    email { "bb@test.com" }
    password { "123456" }
    authority {0}
  end
  factory :admin, class:User do
    name { "Admin" }
    email { "cc@test.com" }
    password { "123456" }
    authority {1}
  end
end
