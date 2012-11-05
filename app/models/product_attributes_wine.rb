class ProductAttributesWine < ActiveRecord::Base
	belongs_to :wine
	belongs_to :product_attribute

	validates :wine, presence: true
	validates :product_attribute, presence: true
end
