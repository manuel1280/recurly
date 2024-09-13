require 'rails_helper'

RSpec.describe V1::TinValidatorService, type: :service do
  describe '.new' do
    let(:unformatted_tin) { '10. 120. 00. 0004 .' }
    let(:country_code) { 'Au' }

    it { expect(V1::TinValidatorService.new(unformatted_tin, country_code).tin).to eq('10120000004') }
    it { expect(V1::TinValidatorService.new(unformatted_tin, country_code).country_code).to eq('au') }
  end
end
