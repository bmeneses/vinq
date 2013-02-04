# == Schema Information
#
# Table name: varietals
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  url         :string(255)
#  winetype_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Varietal < ActiveRecord::Base

  attr_accessible :name, :url, :id

  validates :name, presence: true
  validates :id, uniqueness: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  has_many :wines

  # TODO: make to_param a mixin
  def to_param
  	"#{self.id}-#{self.name.parameterize}"
  end


end
