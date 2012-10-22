# == Schema Information
#
# Table name: product_attributes
#
#  id         :integer         not null, primary key
#  wine_id    :integer
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ProductAttribute < ActiveRecord::Base

  attr_accessible :name, :url, :id

  validates :name, presence: true

  # VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  # validates format: VALID_URL_FORMAT
  has_many :product_attributes_wines 
  has_many :wines, through: :product_attributes_wines

end
