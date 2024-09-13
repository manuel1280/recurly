module V2
  class TinValidatorService
    attr_reader :adapter

    def initialize(type)
      @adapter = set_adapter(type)
    end

    def validate(tin, args = {})
      @adapter.validate(tin, args)
    end

    private

    def set_adapter(type)
      case type
      when 'au_abn'
        V2::AbnService.new
      else
        TinFormat
      end
    end
  end
end
