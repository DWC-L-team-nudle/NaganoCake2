class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name_kana, format: { with:  /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :first_name_kana, format: { with:  /\A[\p{katakana}\p{blank}ー－]+\z/ }

  # KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
end
