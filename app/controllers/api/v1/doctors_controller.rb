class Api::V1::DoctorsController < Api::V1::BaseController
	before_action :load_resource
  before_action :authenticate_doctor

  def show
    render plain: (Api::V1::DoctorSerializer.new(@doctor)).to_json
  end

  def update
    auth_doctor = authorize_with_permissions(@doctor, :update?)

    if @doctor.update(update_params)
      render jsonapi: auth_doctor.record, serializer: Api::V1::DoctorSerializer,
        fields: {doctor: auth_doctor.fields}
    else
      invalid_resource!(@doctor.errors)
    end
  end

  private
    def load_resource
      case params[:action].to_sym
      when :show, :update, :destroy
        @doctor = Doctor.find(params[:id])
      end
    end

    def create_params
      normalized_params.permit(
        :email, :password, :password_confirmation, :name
      )
    end

    def update_params
      create_params
    end

    def normalized_params
      params.to_json
    end
end