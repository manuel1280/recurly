require 'rails_helper'

RSpec.describe TinFormat, type: :model do
  describe '.validate' do
    context 'when validation is successful' do
      context 'returns a validation object with no errors' do
        let(:valid1) { TinFormat.validate('10120000004', country: 'au') }
        let(:valid2) { TinFormat.validate('101200000', country: 'au') }
        let(:valid3) { TinFormat.validate('123456789', country: 'ca') }
        let(:valid4) { TinFormat.validate('22BCDEF1G2FH1Z5', country:'in') }

        it { expect(valid1.errors).to be_empty }
        it { expect(valid1.type).to eq('au_abn') }

        it { expect(valid2.errors).to be_empty }
        it { expect(valid2.type).to eq('au_acn') }

        it { expect(valid3.errors).to be_empty }
        it { expect(valid3.type).to eq('ca_gst') }

        it { expect(valid4.errors).to be_empty }
        it { expect(valid4.type).to eq('in_gst') }
      end
    end

    context 'when validation fails' do
      context 'returns a validation object with errors' do
        let(:valid1) { TinFormat.validate('101200B0004', country: 'au') }
        let(:valid2) { TinFormat.validate('1234567890000', country: 'ca') }
        let(:valid3) { TinFormat.validate('22BCDEF1G', country: 'in') }

        it { expect(valid1.errors).to include('is invalid') }
        it { expect(valid2.errors).to include('is too long') }
        it { expect(valid3.errors).to include('is too short') }
      end
    end
  end
end
