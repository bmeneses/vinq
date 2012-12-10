# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  area_id    :integer
#


class Region < ActiveRecord::Base

	default_scope order("name ASC")

  attr_accessible :region_id, :name, :url, :id

  validates :name, presence: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  has_many :appellations
  belongs_to :area

  # TODO: make to_param a mixin
  def to_param
  	"#{self.id}-#{self.name.parameterize}"
  end
  
end
