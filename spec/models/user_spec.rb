require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全てのカラムデータが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上の半角英数字混合であれば登録できる' do
        @user.password = 'a00000'
        @user.password_confirmation = 'a00000'
        expect(@user).to be_valid
      end
      it 'last_nameが全角文字であれば登録できる' do
        @user.last_name = 'あいうえお'
        expect(@user).to be_valid
      end
      it 'first_nameが全角文字であれば登録できる' do
        @user.first_name = 'あいうえお'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カナであれば登録できる' do
        @user.last_name_kana = 'アイウエオ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角カナであれば登録できる' do
        @user.first_name_kana = 'アイウエオ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birthdayは空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'emailは@が含まれていないと登録ができない' do
        @user.email = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordとpassword_confirmationが5文字以下の場合は登録できない' do
        @user.password = 'a0000'
        @user.password_confirmation = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationは半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationは半角英字のみの場合は登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationは全角の場合は登録できない' do
        @user.password = 'あいうえおか'
        @user.password_confirmation = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'a00000'
        @user.password_confirmation = 'b11111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameは半角英字では登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it 'last_nameは半角数字では登録できない' do
        @user.last_name = '111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end
      it 'first_nameは半角英字では登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      it 'first_nameは半角数字では登録できない' do
        @user.first_name = '111'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end
      it 'last_name_kanaは半角英字では登録できない' do
        @user.last_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it 'last_name_kanaは半角数字では登録できない' do
        @user.last_name_kana = '111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it 'last_name_kanaは全角漢字では登録できない' do
        @user.last_name_kana = '佐藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it 'last_name_kanaは全角ひらがなでは登録できない' do
        @user.last_name_kana = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it 'first_name_kanaは半角英字では登録できない' do
        @user.first_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it 'first_name_kanaは半角数字では登録できない' do
        @user.first_name_kana = '111'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it 'first_name_kanaは全角漢字では登録できない' do
        @user.first_name_kana = '佐藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it 'first_name_kanaは全角ひらがなでは登録できない' do
        @user.first_name_kana = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
    end
  end
end
