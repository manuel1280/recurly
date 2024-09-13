require 'rails_helper'

RSpec.describe V2::AbnService, type: :service do
  subject(:abn_service) { described_class.new }

  let(:tin1) { '10120000004' }
  let(:tin2) { '53004085616' }
  let(:tin3) { '51824753556' }

  describe '.validate' do
    it { expect(subject.validation.type).to eq('au_abn') }

    it 'returns a valid abn' do
      validation = subject.validate(tin1)

      expect(validation.errors).to be_empty
      expect(validation.business_registration['status']).to eq('Active')
      expect(validation.business_registration['organization_name']).to eq('Example Company Pty Ltd')
      expect(validation.business_registration['address']).to_not be_nil
    end

    context 'when api responses with a bad code' do
      it 'returns a external 500 error message' do
        validation = subject.validate(tin2)

        expect(validation.errors).to include('registration API could not be reached')
        expect(validation.business_registration).to eq({})
      end

      it 'returns a external 404 error message' do
        validation = subject.validate(tin3)
        expect(validation.errors).to include('business is not registered')
        expect(validation.business_registration).to eq({})
      end
    end
  end
end
