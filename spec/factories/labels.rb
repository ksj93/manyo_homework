FactoryBot.define do
  factory :label do
    tag { "label1" }
  end
  factory :label2,class:Label do
    tag { "label2" }
  end
  factory :label3,class:Label do
    tag { "label3" }
  end
  factory :label4,class:Label do
    tag { "label4" }
  end
end
