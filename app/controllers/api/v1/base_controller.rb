class Api::V1::BaseController < ActionController::API
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    render plain: {message: "Not found"}.to_json
  end

  def authenticate_doctor!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(
      request
    )

    return nil unless token && options.is_a?(Hash)

    doctor = Doctor.find_by(email: options['email'])
    if doctor && ActiveSupport::SecurityUtils.secure_compare(doctor.token, token)
      @current_doctor = doctor
    else
      return UnauthenticatedError
    end
  end
end