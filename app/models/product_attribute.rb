# == Schema Information
#
# Table name: product_attributes
#
#  id                   :integer         not null, primary key
#  product_attribute_id :integer
#  wine_id              :integer
#  name                 :string(255)
#  url                  :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

class ProductAttribute < ActiveRecord::Base

  attr_accessible :product_attribute_id, :name, :url

  validates :product_attribute_id, :name, presence: true, uniqueness: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  has_and_belongs_to_many :wines
  

end
