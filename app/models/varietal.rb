# == Schema Information
#
# Table name: varietals
#
#  id          :integer         not null, primary key
#  varietal_id :integer
#  name        :string(255)
#  url         :string(255)
#  winetype_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Varietal < ActiveRecord::Base

  attr_accessible :varietal_id, :name, :url, :id

  validates :varietal_id, :name, presence: true, uniqueness: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  # has_one :winetype

end
