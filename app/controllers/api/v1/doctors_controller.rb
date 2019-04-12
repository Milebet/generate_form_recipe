class Api::V1::DoctorsController < Api::V1::BaseController
  #include Pundit
	before_action :load_resource
  before_action :authenticate_doctor

  def validate_doctor
    @doctor = Doctor.find_by(email: params[:email])
    if @doctor
      render json: Api::V1::DoctorSerializer.new(@doctor)
    else
      render json: {doctor: "not found"}
    end
  end

  def show
    render json: (Api::V1::DoctorSerializer.new(@doctor))
  end

  def update
    if @doctor.update(update_params)
      render json: (Api::V1::DoctorSerializer.new(@doctor))
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
      params.permit(
      :email, :password, :password_confirmation, :document_type, 
      :document, :first_name, :second_name, :last_name, :second_last_name, :married_name, 
      :birth_date, :genre, :speciality, :years_experience, :country, :city, :address, 
      :local_phone, :cell_phone, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
      )
    end

    def update_params
      create_params
    end

    def normalized_params
      params.to_json
    end
end