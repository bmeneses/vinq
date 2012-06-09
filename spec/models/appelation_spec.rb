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

require 'spec_helper'

describe Appelation do

  let(:wine) { FactoryGirl.create(:wine) }

  before { wine.build_appelation(appelation_id: "123",
                                 name: "Barossa Valley",
                                 url: "http://www.google.com") }

  subject { wine.appelation }

  it_behaves_like "a wine_attribute"

end

