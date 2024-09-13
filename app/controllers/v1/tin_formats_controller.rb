class V1::TinFormatsController < ApplicationController
  before_action :validate_country_code

  def validate
    validation = V1::TinValidatorService.call(tin_params[:tin], tin_params[:country_code])

    validation_response(validation)
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
