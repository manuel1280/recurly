require 'rails_helper'

RSpec.describe "TinFormats", type: :request do
  describe "POST /validate" do
    context 'v1' do
      it "returns http success" do
        post "/api/v1/tin_formats/validate", params: { country_code: 'au', tin: '10120000004' }

        expect(response).to have_http_status(:success)
        body_response = JSON.parse(response.body)

        expect(body_response['valid']).to eq(true)
        expect(body_response['tin_type']).to eq('au_abn')
        expect(body_response['formatted_tin']).to eq('10 120 000 004')
        expect(body_response['errors']).to eq([])
      end

      it "returns http unprocessable_entity" do
        post "/api/v1/tin_formats/validate", params: { country_code: 'in', tin: '2ABCDEF1G2FH1Z5' }

        expect(response).to have_http_status(:bad_request)
        body_response = JSON.parse(response.body)

        expect(body_response['valid']).to eq(false)
        expect(body_response['errors']).not_to eq([])
      end

      it "returns http not found" do
        post "/api/v1/tin_formats/validate", params: { country_code: 'co', tin: '1014257774' }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'v2' do
      it "returns http success" do
        post "/api/v2/tin_formats/validate", params: { country_code: 'au', tin: '10120000004' }

        expect(response).to have_http_status(:success)
        body_response = JSON.parse(response.body)

        expect(body_response['valid']).to eq(true)
        expect(body_response['tin_type']).to eq('au_abn')
        expect(body_response['formatted_tin']).to eq('10 120 000 004')
        expect(body_response['errors']).to eq([])
        expect(body_response['business_registration']).not_to eq(nil)
      end

      it "returns http unprocessable_entity" do
        post "/api/v2/tin_formats/validate", params: { country_code: 'in', tin: '2ABCDEF1G2FH1Z5' }

        expect(response).to have_http_status(:bad_request)
        body_response = JSON.parse(response.body)

        expect(body_response['valid']).to eq(false)
        expect(body_response['errors']).not_to eq([])
      end

      it "returns http not found" do
        post "/api/v2/tin_formats/validate", params: { country_code: 'co', tin: '1014257774' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
