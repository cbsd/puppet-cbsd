require 'spec_helper'
describe 'cbsd' do

  context 'with default values for all parameters' do
    it { should contain_class('cbsd') }
  end
end
