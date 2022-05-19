class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name_kana, format: { with:  /\A[\p{katakana}\p{blank}ー－]+\z/ }
  validates :first_name_kana, format: { with:  /\A[\p{katakana}\p{blank}ー－]+\z/ }

  has_many :addresses, dependent: :destroy

  # is_deletedがfalseならtrueを返すようにしている、
  #退会したら再度ログインできないようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
