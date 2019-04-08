class Api::V1::BaseController < ActionController::API
	include Pundit
  include ActiveHashRelation
  include CustomErrors

  before_action :authenticate_doctor!
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    render plain: {message: "Not found"}.to_json
  end

  rescue_from ActionController::ParameterMissing do
    api_error(status: 400, errors: 'Invalid parameters')
  end

  rescue_from Pundit::NotAuthorizedError do
    unauthorized!
  end

  rescue_from UnauthenticatedError do
    unauthenticated!
  end

  protected
    def current_user
      @current_user
    end

    def authenticate_doctor
      #token, options = ActionController::HttpAuthentication::Token.token_and_options(
      #  request
      #)

      #return nil unless token && options.is_a?(Hash)
      #if doctor && ActiveSupport::SecurityUtils.secure_compare(doctor.token, token)
      #  @current_user = doctor
      #else
      #  return nil
      #end
      return nil if !request.query_parameters.present? ||
                    (!request.query_parameters.keys.include?("email") &&
                     !request.query_parameters.keys.include?("password"))
      options = request.query_parameters
      doctor = Doctor.find_by(email: options["email"])
      doctor&.valid_password?(options["password"]) ? doctor : nil
    end

    def authenticate_doctor!
      authenticate_doctor or raise UnauthenticatedError
    end

    def unauthorized!
      unless Rails.env.production? || Rails.env.test?
        Rails.logger.warn { "unauthorized for: #{current_user.try(:id)}" }
      end

      api_error(status: 403, errors: 'Not Authorized')
    end

    def unauthenticated!
      unless Rails.env.production? || Rails.env.test?
        Rails.logger.warn { "Unauthenticated doctor not granted access" }
      end

      api_error(status: 401, errors: 'Not Authenticated')
    end

    def not_found!
      Rails.logger.warn { "not_found for: #{current_user.try(:id)}" }

      api_error(status: 404, errors: 'Resource not found')
    end

    def invalid_resource!(errors = [])
      api_error(status: 422, errors: errors)
    end

    def api_error(status: 500, errors: [])
      puts errors.full_messages if errors.respond_to?(:full_messages)

      render json: Api::V1::ErrorSerializer.new(status, errors).as_json,
        status: status
    end
end