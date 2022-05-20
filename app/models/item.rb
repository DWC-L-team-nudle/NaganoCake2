class Item < ApplicationRecord

  has_one_attached :item_image

  has_many :orders, through: :order_details
  has_many :order_details
  has_many :cart_items, dependent: :destroy
  belongs_to :genre

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :genre_id
    validates :is_active
  end

  def with_tax_price
        (price * 1.1).floor
  end

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end