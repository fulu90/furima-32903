FactoryBot.define do
  factory :order_address do
      postcode  { '111-1111' } 
      prefecture_id { 2 }
      city { '札幌市' }
      block { '1-1' }
      building { 'ハイツ101' }
      phone_number { '09012345678' }
  end
end
