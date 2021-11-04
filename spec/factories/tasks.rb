FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    status { '未着手' }
    deadline { '2100-12-29' }
    priority { 0 }
  end
  factory :second_task, class:Task do
    title { 'test_title2' }
    content { 'test_content2' }
    status { '未着手' }
    deadline { '2100-12-30' }
    priority { 1 }
  end
  factory :third_task, class:Task do
    title { 'test_title3' }
    content { 'test_content3' }
    status { '未着手' }
    deadline { '2100-12-31' }
    priority { 2 }
  end
  factory :task_search, class:Task do
    title { 'test_aa' }
    content { 'test_content' }
    status { '未着手' }
    deadline { '2100-12-27' }
    priority { 0 }
  end
  factory :task2_search, class:Task do
    title { 'test_bb' }
    content { 'test_content2' }
    status { '着手' }
    deadline { '2100-12-28' }
    priority { 1 }
  end
  factory :task3_search, class:Task do
    title { 'test_cc' }
    content { 'test_content3' }
    status { '完了' }
    deadline { '2100-12-29' }
    priority { 2 }
  end
  factory :task4_search, class:Task do
    title { 'test_dd' }
    content { 'test_content4' }
    status { '未着手' }
    deadline { '2100-12-30' }
    priority { 0 }
  end
  factory :task5_search, class:Task do
    title { 'test_ee' }
    content { 'test_content5' }
    status { '着手' }
    deadline { '2100-12-31' }
    priority { 1 }
  end
end
