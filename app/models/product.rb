class Product < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :price, presence: true, numericality: { greater_than: 0 }

	validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\z}i
    }

    has_many :favorite_products 
  	has_many :favorited_by, :through => :favorite_products, :source => :user
end