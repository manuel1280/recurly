class ApplicationController < ActionController::API
  include TinHelper

  def validation_response(validation)
    if validation.errors.any?
      render json: { valid: false, errors: validation.errors.uniq }, status: :bad_request
    else
      render json: {
        valid: true,
        tin_type: validation.type,
        formatted_tin: formatted_tin(validation.type, params[:tin]),
        errors: [],
        business_registration: validation.members.include?(:business_registration) ? validation.business_registration : nil
      },
      status: :ok
    end
  end
end
