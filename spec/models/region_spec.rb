# == Schema Information
#
# Table name: regions
#
#  id         :integer         not null, primary key
#  region_id  :integer
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  area_id    :integer
#

require 'spec_helper'

describe Region do

  let(:wine) { FactoryGirl.create(:wine) }

  before do
    wine.build_appelation(appelation_id: "123",
                          name: "Barossa Valley",
                          url: "http://www.google.com")
    
    wine.appelation.build_region(region_id: "555",
                                 name: "Australia",
                                 url: "http://www.wine.com.au/")
  end

  subject { wine.appelation.region }

  it_behaves_like "a wine_attribute"

end
