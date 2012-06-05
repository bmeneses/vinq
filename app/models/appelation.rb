class Appelation < ActiveRecord::Base

  attr_accessible :appelation_id, :name, :url

  validates :appelation_id, :name, presence: true

  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :url, presence: true, format: VALID_URL_FORMAT

  belongs_to :region

end
