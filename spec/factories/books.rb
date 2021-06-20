FactoryBot.define do
  factory :book, class: Book do
    title { 'Sample Title' }
    author { 'Sample Author' }
  end

  factory :update_book, class: Book do
    title { 'Updated Sample Title' }
    author { 'Updated Sample Author' }
  end
end
