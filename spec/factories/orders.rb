FactoryBot.define do
  factory :order do
    output { 1 }
    year_and_month { '2022-11-1' }
    menu_id { 1 }
    user_id { 1 }
  end
end
