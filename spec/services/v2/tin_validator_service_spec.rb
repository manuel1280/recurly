require 'rails_helper'

RSpec.describe V2::TinValidatorService, type: :service do
  describe '.new' do
    let(:au_format) { 'au_abn' }
    let(:other_format) { 'in_gst' }

    it { expect(V2::TinValidatorService.new(au_format).adapter.class).to eq(V2::AbnService) }
    it { expect(V2::TinValidatorService.new(other_format).adapter.name).to eq('TinFormat') }
  end
end
