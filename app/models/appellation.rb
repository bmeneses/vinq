
# == Schema Information
#
# Table name: appellations
#
#  id            :integer         not null, primary key
#  appellation_id :integer
#  name          :string(255)
#  url           :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  region_id     :integer
#

class Appellation < ActiveRecord::Base

  attr_accessible :appellation_id, :name, :url, :id

  validates :appellation_id, :name, presence: true, uniqueness: true
  
  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :region
  has_one :area, through: :region

end