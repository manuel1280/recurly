require 'rails_helper'

RSpec.describe AbnService, type: :service do
  describe '.call' do
    let(:formatted_tin) { '10120000004' }
    let(:invalid_tin) { '10120080004' }

    it 'returns an aun_abn type' do
      validation = AbnService.call(formatted_tin)
      expect(validation.type).to eq('au_abn')
    end

    it 'returns a validation object with no errors' do
      validation = AbnService.call(formatted_tin)
      expect(validation.errors).to be_empty
    end

    it 'returns a validation object with errors' do
      validation = AbnService.call(invalid_tin)
      expect(validation.errors).to include('is invalid')
    end
  end
end
