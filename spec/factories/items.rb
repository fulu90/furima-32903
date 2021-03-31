FactoryBot.define do
  factory :item do
    product_name          { Faker::Commerce.product_name }
    description           { Faker::Lorem.characters }
    category_id           { rand(2..11) }
    status_id             { rand(2..7) }
    postage_id            { rand(2..3) }
    region_id             { rand(2..48) }
    shippingdate_id       { rand(2..4) }
    selling_price         { rand(300..9_999_999) }
    association :user
  end
end
