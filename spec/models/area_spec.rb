# == Schema Information
#
# Table name: areas
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Area do

  let(:area) { FactoryGirl.create(:area) }

  subject { area }

  it_behaves_like "a general_attribute"

end


