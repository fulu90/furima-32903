class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :region
  belongs_to :shippingdate

  validates :product_name,:description,:selling_price, presence: true

  validates :category_id,:status_id,:postage_id,:region_id,
            :shippingdate_id, numericality: { other_than: 1 }
end
