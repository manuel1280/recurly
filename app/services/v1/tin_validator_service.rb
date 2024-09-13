module V1
  class TinValidatorService < ApplicationService
    include TinHelper
    attr_reader :tin, :country_code

    def initialize(tin, country_code)
      @tin = parameterize_tin(tin)
      @country_code = country_code.downcase
    end

    def call
      if country_code == 'au' && tin.length == 11
        V1::AbnService.call(tin)
      else
        TinFormat.validate(tin, country: country_code)
      end
    end
  end
end