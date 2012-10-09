# == Schema Information
#
# Table name: appellations
#
#  id         :integer(8)      not null, primary key
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  region_id  :integer(8)
#

require 'spec_helper'

describe Appellation do

  let(:appellation) { FactoryGirl.create(:appellation) }

  subject { appellation }

  it_behaves_like "a general_attribute"

end

