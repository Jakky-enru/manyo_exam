FactoryBot.define do
  factory :task do
    name { 'タイトル１' }
    content { 'コンテント１' }
    deadline { '2023-03-10' }
    status { '着手中' }
    priority { '高' }
  end

  factory :second_task, class: Task do
    name { 'タイトル２' }
    content { 'コンテント２' }
    deadline { '2023-03-11' }
    status {'未着手'}
    priority { '中' }
  end
end