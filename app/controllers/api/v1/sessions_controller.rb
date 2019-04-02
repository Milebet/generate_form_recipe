class Api::V1::SessionsController < Api::V1::BaseController
  def create
    if @doctor
      render(
        json: @doctor,
        serializer: Api::V1::SessionSerializer,
        status: 201,
        include: [:doctor],
        scope: @doctor
      )
    else
      return api_error(status: 401, errors: 'Wrong password or username')
    end
  end

  private
    def create_params
      normalized_params.permit(:email, :password)
    end

    def load_resource
      @doctor = Doctor.find_by(
        email: create_params[:email]
      )&.authenticate(create_params[:password])
    end

    def normalized_params
      ActionController::Parameters.new(
         ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      )
    end
end