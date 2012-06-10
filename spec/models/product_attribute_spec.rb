# == Schema Information
#
# Table name: product_attributes
#
#  id                   :integer         not null, primary key
#  product_attribute_id :integer
#  wine_id              :integer
#  name                 :string(255)
#  url                  :string(255)
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#

require 'spec_helper'

describe ProductAttribute do

  let(:product_attribute) { FactoryGirl.create(:product_attribute) }

  subject { product_attribute }

  it_behaves_like "a general_attribute"

end
