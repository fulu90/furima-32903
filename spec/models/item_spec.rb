require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/image.png')
  end

  describe '商品出品' do
    context '商品出品ができるとき' do
      it '全てのカラムデータが存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it '販売価格が半角数字で300円以上であれば出品できる' do
        @item.selling_price = 300
        expect(@item).to be_valid
      end
      it '販売価格が半角数字で9,999,999円以内であれば出品できる' do
        @item.selling_price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it '商品画像が未選択では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリー情報が未選択では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '商品の状態が未選択では出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it '配送料の負担が未選択では出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage Select')
      end
      it '発送元の地域が未選択では出品できない' do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Region Select')
      end
      it '発送までの日数が未選択では出品できない' do
        @item.shippingdate_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shippingdate Select')
      end
      it '販売価格が空では出品できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it '販売価格が300円より少ないと出品できない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Out of setting range')
      end
      it '販売価格が9,999,999円より多いと出品できない' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Out of setting range')
      end
      it '販売価格が半角英字では出品できない' do
        @item.selling_price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Half-width number')
      end
      it '販売価格が全角数字では出品できない' do
        @item.selling_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price Half-width number')
      end
    end
  end
end
