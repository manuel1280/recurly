class V2::TinFormatsController < ApplicationController
  before_action :validate_country_code

  def validate
    basic_validation = TinFormat.validate(tin_params[:tin], country: tin_params[:country_code])

    if basic_validation.errors.any?
      render json: { valid: false, errors: basic_validation.errors.uniq }, status: :bad_request
    else
      validation = V2::TinValidatorService.new(basic_validation.type).validate(tin_params[:tin], country: tin_params[:country_code])

      validation_response(validation)
    end
  end

  private

  def tin_params
    params.permit(:country_code, :tin)
  end

  def validate_country_code
    unless TinFormat::RULES.keys.include?(tin_params[:country_code])
      render json: { errors: "Country code not found" }, status: :not_found
    end
  end
end
