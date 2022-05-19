class Item < ApplicationRecord
  has_one_attached :item_image
  has_many :order_details
  belongs_to :genre
  
  def with_tax_price
        (price * 1.1).floor
  end

  def get_item_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end
end
