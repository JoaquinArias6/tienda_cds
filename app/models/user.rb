class User < ApplicationRecord
	validates :name, presence: true
	validates :username, presence: true, uniqueness: true

	has_secure_password

	has_many :products

	has_many :favorite_products
  	has_many :favorites, :through => :favorite_products, :source => :product
end