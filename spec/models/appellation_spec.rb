# == Schema Information
#
# Table name: appellations
#
#  id            :integer         not null, primary key
#  appellation_id :integer
#  name          :string(255)
#  url           :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  region_id     :integer
#

require 'spec_helper'

describe Appellation do

  let(:appellation) { FactoryGirl.create(:appellation) }

  subject { appellation }

  it_behaves_like "a general_attribute"

end

