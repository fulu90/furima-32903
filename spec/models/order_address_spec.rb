require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入' do
    context '商品購入ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
      it 'phone_numberが数字10桁でも保存ができること' do
        @order_address.phone_number = '0120123456'
        expect(@order_address).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'postcodeが空だと保存できないこと' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが半角ハイフンがないと保存ができないこと' do
        @order_address.postcode = '1112222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'postcodeは全角文字が含まれている場合は保存できないこと' do
        @order_address.postcode = '111ー2222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'postcodeは半角英字が含まれている場合は保存できないこと' do
        @order_address.postcode = 'a12-b123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'postcodeは適切な形（半角数字[3]-[4]）でなければ保存できないこと' do
        @order_address.postcode = '11-22222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが空（"1"の場合）だと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空だと保存できないこと' do
        @order_address.block = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは半角ハイフンがあると保存ができないこと' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは１２桁以上の場合は保存できないこと' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは全角文字が含まれている場合は保存できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは半角英字が含まれている場合は保存できないこと' do
        @order_address.phone_number = 'abc'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end