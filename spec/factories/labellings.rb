FactoryBot.define do
  factory :labelling do
    task { nil }
    label { [nil,nil] }
  end
  factory :labellings,class:Labelling do
    task { nil }
    label { [test1,test2] }
  end
end
