FactoryBot.define do
  sequence :name do |n|
    "Product#{n}"
  end

  sequence :price do |n|
    rand(100..50000)
  end

  factory :product do
    name
    price
  end
end