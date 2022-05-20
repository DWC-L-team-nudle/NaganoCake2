class OrderDetail < ApplicationRecord
  belongs_to :order, dependent: :destroy
  has_many :items
end
