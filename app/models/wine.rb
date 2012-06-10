# == Schema Information
#
# Table name: wines
#
#  id                   :integer         not null, primary key
#  wine_id              :string(255)
#  name                 :string(255)
#  url                  :string(255)
#  type                 :string(255)
#  year                 :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  appelation_id        :integer
#  varietal_id          :integer
#  price_min            :decimal(, )
#  price_max            :decimal(, )
#  price_retail         :decimal(, )
#  product_attribute_id :integer
#

class Wine < ActiveRecord::Base

  attr_accessible :wine_id, :name, :url, :type, :year


  validates :wine_id, :name, :type, presence: true
  validates :wine_id, uniqueness: true
  validates :year, presence: true, 
                   numericality: { less_than_or_equal_to: Time.now.year }

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :appelation
  belongs_to :varietal
  has_and_belongs_to_many :product_attributes

  # helpers
  def region
    appelation.region
  end

  def area
    appelation.region.area
  end
  

end
