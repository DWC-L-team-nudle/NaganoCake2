class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }

  with_options presence: true do
    validates :customer_id
    validates :postal_code
    validates :address
    validates :name
    validates :shopping_fee
    validates :total_payment
    validates :payment_method
    validates :status
  end

  def status_display
    status_i18n
  end

  # 小計計算メソッド
  def subtotal
    item.with_tax_price * amount
  end

end
