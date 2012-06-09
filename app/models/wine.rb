# == Schema Information
#
# Table name: wines
#
#  id            :integer         not null, primary key
#  product_id    :string(255)
#  name          :string(255)
#  url           :string(255)
#  type          :string(255)
#  year          :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  appelation_id :integer
#

class Wine < ActiveRecord::Base

  attr_accessible :product_id, :name, :url, :type, :year

  validates :product_id, :name, :type, presence: true, uniqueness: true
  validates :year, presence: true, 
                   numericality: { less_than_or_equal_to: Time.now.year }

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :appelation
  belongs_to :varietal


  # helpers
  def region
    appelation.region
  end

  def area
    appelation.region.area
  end
  

end
