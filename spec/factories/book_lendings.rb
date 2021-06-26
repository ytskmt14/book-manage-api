FactoryBot.define do
  factory :book_lending, class: BookLending do
    start_dt { '2021-06-20' }
    end_dt { '2021-07-20' }
    returned_flg { false }
    is_cancelled { false }
    association :book
  end

  factory :sample_lending, class: BookLending do
    start_dt { '2021-01-20' }
    end_dt { '2021-02-20' }
    returned_flg { false }
    is_cancelled { false }
    association :book
  end

  factory :new_lending, class: BookLending do
    start_dt { '2021-10-20' }
    end_dt { '2021-11-20' }
    returned_flg { false }
    is_cancelled { false }
    association :book
  end
end
