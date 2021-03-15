# テーブル設計

## users テーブル

| Column                | Type    | Options                   |
| --------------------- | ------- | ------------------------- |
| nickname              | string  | null: false               |
| email                 | string  | null: false, unique: true |
| password              | string  | null: false               |
| last_name             | string  | null: false               |
| first_name            | string  | null: false               |
| last_name_kana        | string  | null: false               |
| first_name_kana       | string  | null: false               |
| birth_year            | date    | null: false               |
| birth_month           | date    | null: false               |
| birth_day             | date    | null: false               |

### Association

- has_many :items
- has_many :buys


## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| image            | string     | null: false                    |
| product_name     | string     | null: false                    |
| description      | text       | null: false                    |
| category         | string     | null: false                    |
| product_status   | string     | null: false                    |
| shipping_charges | string     | null: false                    |
| shipping_area    | string     | null: false                    |
| days_to_ship     | string     | null: false                    |
| selling_price    | integer    | null: false                    |
| user             | references | null: false, foreign_key: true | 

### Association

- belongs_to :user
- has_one :buy


## buys テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| card_information | string     | null: false                    |
| expiration_month | date       | null: false                    |
| expiration_year  | date       | null: false                    |
| security_code    | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefectures   | string     | null: false                    |
| city_name     | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| phone_number  | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association

- belongs_to :buy
