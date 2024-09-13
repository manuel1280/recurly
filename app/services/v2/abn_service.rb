module V2
  class AbnService < ValidationAdapter
    include TinHelper
    Validation = Struct.new(:errors, :type, :business_registration)

    attr_reader :validation

    def initialize
      @meta_data = {}
      @validation = Validation.new([],'au_abn',@meta_data)
    end

    def validate(tin, *args)
      @tin = parameterize_tin(tin)

      response = AuAbnClient.new(@tin).validate

      if response[:error].nil?
        @validation.business_registration = map_business_entity(response[:body])
      else
        @validation.errors << response[:error]
      end

      @validation

    rescue StandardError => e
      @validation.errors << e.message
    end

    private

    def map_business_entity(data)
      @meta_data['business_registration'] = {
        'status' => extract_text('status', data),
        'organization_name' => extract_text('organisationName', data),
        'address' => extract_text('address', data)
      }
    end

    def extract_text(label, data)
      regex = "(?<=<#{label}>).*?(?=</#{label}>)"
      pattern = Regexp.new(regex)
      data.match(pattern).to_s
    end
  end
end
