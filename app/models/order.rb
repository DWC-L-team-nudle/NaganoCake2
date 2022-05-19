class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  # enum payment_method: { credit_card: 0, transfer: 1 }
  # enum status: { waiting: 0, payment_confirm: 1, making: 2, ready_to_ship: 3, send: 4 }

  with_options presence: true do
    validates :customer_id
    validates :postal_code
    validates :address
    validates :name
    validates :shipping_cost
    validates :total_payment
    validates :payment_method
    validates :status
  end

  def status_display
    status_i18n
  end
end
