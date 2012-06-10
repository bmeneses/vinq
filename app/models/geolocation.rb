# == Schema Information
#
# Table name: geolocations
#
#  id         :integer         not null, primary key
#  lat        :float
#  long       :float
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# TODO: once I get access to the full API need to add validations for
# lat +/- 90 and long +/- 180

# Class for storing geolocations from the wine.com api.
# belongs to many attribute-like objects.
class Geolocation < ActiveRecord::Base

  attr_accessible :lat, :long, :url  

  validates :lat, :long, presence: true, numericality: true
  VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  
  validates :url, presence: true, format: VALID_URL_FORMAT

end
