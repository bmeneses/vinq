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

require 'spec_helper'

describe Varietal do

  let(:varietal) { FactoryGirl.create(:varietal) }

  subject { varietal }

  it_behaves_like "a general_attribute"

  #it { should respond_to(:winetype) }


end
