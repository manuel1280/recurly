class V1::TinFormatsController < ApplicationController
  before_action :validate_country_code

  def validate
    tin_format = TinValidatorService.call(tin_params[:tin], tin_params[:country_code])

    if tin_format.errors.any?
      render json: { valid: false, errors: tin_format.errors.uniq }, status: :bad_request
    else
      render json: {
        valid: true,
        tin_type: tin_format.type,
        formatted_tin: formatted_tin(tin_format.type, tin_params[:tin]),
        errors: []
      },
      status: :ok
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
