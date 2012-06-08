
# == Schema Information
#
# Table name: appelations
#
#  id            :integer         not null, primary key
#  appelation_id :integer
#  name          :string(255)
#  url           :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  region_id     :integer
#

class Appelation < ActiveRecord::Base

  attr_accessible :appelation_id, :name, :url

  validates :appelation_id, :name, presence: true, uniqueness: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :region
  has_one :area, through: :region

end