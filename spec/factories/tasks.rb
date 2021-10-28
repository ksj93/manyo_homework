FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    status { '未着手' }
    deadline { '2100-12-29' }
    priority { '普通' }
  end
  factory :second_task, class:Task do
    title { 'test_title2' }
    content { 'test_content2' }
    status { '未着手' }
    deadline { '2100-12-30' }
    priority { '普通' }
  end
  factory :third_task, class:Task do
    title { 'test_title3' }
    content { 'test_content3' }
    status { '未着手' }
    deadline { '2100-12-31' }
    priority { '普通' }
  end
end
