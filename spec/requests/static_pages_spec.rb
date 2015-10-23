require 'spec_helper'

describe 'StaticPages' do

  subject { page }

  describe 'Home page' do
    before { visit root_path }

    it { should have_content('Home Manager') }
  end

  describe 'Contact page' do

    before { visit contact_path }

    it { should have_content('Contact') }
  end
end
