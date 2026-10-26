require 'rails_helper'

RSpec.describe 'filter_parameters' do
  let(:filter) { ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters) }

  it 'masks password, including nested params' do
    out = filter.filter('password' => 'rahasia', 'authentication' => { 'password' => 'rahasia' })
    expect(out['password']).to eq('[FILTERED]')
    expect(out['authentication']['password']).to eq('[FILTERED]')
  end

  it 'masks token and email' do
    out = filter.filter('token' => 'abc', 'email' => 'x@example.test')
    expect(out.values).to all(eq('[FILTERED]'))
  end

  it 'leaves harmless params visible' do
    expect(filter.filter('page' => '1')['page']).to eq('1')
  end
end
