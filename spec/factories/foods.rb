FactoryBot.define do
  factory :food do
    name { 'factory_food' }
    unit_price_per_kilo { 1 }
    user_id { 1 }
  end
end
