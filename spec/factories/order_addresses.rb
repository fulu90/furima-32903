FactoryBot.define do
  factory :order_address do
    postcode { '111-1111' }
    prefecture_id { 2 }
    city { '札幌市' }
    block { '1-1' }
    building { 'ハイツ101' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
    user_id { 1 }
    item_id { 1 }
  end
end
