# == Schema Information
#
# Table name: wines
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  url                  :string(255)
#  wine_type            :string(255)
#  year                 :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  appellation_id       :integer
#  varietal_id          :integer
#  price_min            :decimal(, )
#  price_max            :decimal(, )
#  price_retail         :decimal(, )
#  product_attribute_id :integer
#

class Wine < ActiveRecord::Base
  include SharedCallbacksValidations

  attr_accessible :name, :url, :wine_type, :year, :price_min, :price_max,
                  :price_retail, :id


  validates :name, :wine_type, presence: true
  validates :id, uniqueness: true
  # validates :year, presence: true, 
  #                  numericality: { less_than_or_equal_to: Time.now.year }

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :appellation
  belongs_to :varietal
  has_many :product_attributes_wines
  has_many :product_attributes, through: :product_attributes_wines 

  

  # helpers
  def region
    appellation.region
  end

  def area
    appellation.region.area
  end
  
  def label(size)
    @label_base_url = "http://cache.wine.com/labels"
    size == :thumb ? img_size = 'm' : img_size = 'l'
    "#{@label_base_url}/#{id}#{img_size}.jpg" unless (id == nil) 
  end





end
