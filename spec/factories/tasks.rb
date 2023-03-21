FactoryBot.define do
  factory :task do
    name { 'タイトル１' }
    content { 'コンテント１' }
  end

  factory :second_task, class: Task do
    name { 'タイトル２' }
    content { 'コンテント２' }
  end
end