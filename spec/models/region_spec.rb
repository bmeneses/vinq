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

  let(:region) { FactoryGirl.create(:region) }

  subject { region }

  it_behaves_like "a general_attribute"

end
