# == Schema Information
#
# Table name: houses
#
#  id         :integer          primary key
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe House do

  before { @house = House.new(name:'Dummy House',
                              address: '1234 Street',
                              city: 'Cluj-Napoca',
                              country: 'Romania') }

  subject { @house }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:country) }

  it { should be_valid }

  describe 'when name is not present' do

    before { @house.name = ' ' }

    it { should_not be_valid }
  end

  describe 'when address is not present' do

    before { @house.address = ' ' }

    it { should_not be_valid }
  end

  describe 'when city is not present' do

    before { @house.city = ' ' }

    it { should_not be_valid }
  end

  describe 'when country is not present' do

    before { @house.country = ' ' }

    it { should_not be_valid }
  end

  describe 'when name is too long' do

    before { @house.name = 'a' * 151 }

    it { should_not be_valid }
  end

  describe 'when address is too short' do

    before { @house.address = 'aaa' }

    it { should_not be_valid }
  end

  describe 'when address is too long' do

    before { @house.address = 'a' * 251 }

    it { should_not be_valid }
  end

  describe 'when city is too long' do

    before { @house.city = 'a' * 151 }

    it { should_not be_valid }
  end

  describe 'when country is too long' do

    before { @house.country = 'a' * 151 }

    it { should_not be_valid }
  end

  describe 'when address and city are already taken' do

    before do
      house_with_same_address = @house.dup
      house_with_same_address.save
    end

    it { should_not be_valid }
  end
end
