class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :block, :building, :phone_number

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :block
    validates :phone_number format: { with: /\A\d{10,11}\z/ }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    user = User.create(nickname:nickname,email:email,encrypted_password:encrypted_password,last_name:last_name,first_name:first_name,last_name_kana:last_name_kana,first_name_kana:first_nama_kana,birthday:birthday)
    item = Item.create(product_name:product_name,description:description,category_id:category_id,status_id:status_id,postage_id:postage_id,region_id:region_id,shippingdate_id:shippingdate_id,selling_price:selling_price,user_id:user.id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
    Order.create(user_id: user.id, item_id: item.id)
  end
end