class Api::V1::BaseController < ActionController::API
	include Pundit
  include ActiveHashRelation
  include CustomErrors

  #before_action :authenticate_doctor!
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

    def valid_authenticated? request
      options = {}
      return nil if !request[:email].present? && !request[:id].present? && !params[:doctor_id].present?
      if params[:action] == "validate_doctor"
        options[:authentication] = {email: request[:email]}
        if request.request_parameters.keys.include?("password")
          options[:authentication][:password] = request.request_parameters['password']
        end
      elsif params[:controller].match(/recipe/).present?
        options[:authentication] = {id: params[:doctor_id]}
        options[:authentication][:token] = request.authorization
      else
        return nil if !request.authorization.present?
        options[:authentication] = {id: request[:id]}
        options[:authentication][:token] = request.authorization
      end
      options
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
      request_params = valid_authenticated?(request)
      return nil if !request_params.present?
      if params[:action] == "validate_doctor"
        doctor = Doctor.find_by(email: request_params[:authentication][:email])
        return false if !doctor.present?
        doctor.valid_password?(request_params[:authentication][:password]) ? true : false
      else
        doctor = Doctor.find(request_params[:authentication][:id])
        return false if !doctor.present? || !request_params[:authentication][:token].present?
        ActiveSupport::SecurityUtils.secure_compare(doctor.token, request_params[:authentication][:token]) ? true : false
      end
    end

    def authenticate_doctor!
      authenticate_doctor or raise UnauthenticatedError
    end

    def authenticate_recipe
      request_params = valid_authenticated?(request)
      return nil if !request_params.present?
      doctor = Doctor.find(request_params[:authentication][:id])
      return false if !doctor.present? || !request_params[:authentication][:token].present?
      return false if !ActiveSupport::SecurityUtils.secure_compare(doctor.token, request_params[:authentication][:token])
      if !["create", "recipes_doctor"].include? params[:action].to_s.downcase
        recipe = Recipe.find(params[:id]) rescue nil
        return false if recipe.nil?
        recipe.doctor_id == doctor.id ? true : false
      else
        true
      end
    end

    def authenticate_recipe!
      authenticate_recipe or raise UnauthenticatedError
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