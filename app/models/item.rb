class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :region
  belongs_to :shippingdate
  belongs_to :user
  has_one :order
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :selling_price, format: { with: /\A[0-9]+\z/, message: 'Half-width number' },
                              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }
  end

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :region_id
    validates :shippingdate_id
  end
end
