require 'base64'
class Api::V1::DoctorsController < Api::V1::BaseController
  #include Pundit
	before_action :load_resource
  before_action :authenticate_doctor!

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

    #file = Paperclip.io_adapters.for(params[:photo][:image])
    #file.original_filename = params[:photo][:filename]
    #@photo = Photo.new(file: file, user: current_user)
    #@photo.save

  def update
    if params["photo"].present?
      #file = Paperclip.io_adapters.for(params[:photo])
      #file.original_filename = params[:photo][:filename]
      #@doctor.image = file
    end
    if @doctor.update(update_params)
      render json: (Api::V1::DoctorSerializer.new(@doctor))
    else
      invalid_resource!(@doctor.errors)
    end
  end

  def reset_password
    return render json: {error: 'No ha enviado un correo electrónico'} if !params[:email].present?
    @doctor = Doctor.find_by(email: params[:email])
    if !@doctor.present?
      return render json: {error: 'El correo electrónico no se encuentra en nuestra base de datos.'}
    else
      @generated_password = Devise.friendly_token.first(6)
      @doctor.password = @generated_password
      if @doctor.save
        RecipeMailer.password_reset(@doctor, @generated_password).deliver_now
        return render json: {success: "Ok"}
      else
        return render json: {error: 'Ha ocurrdo un error al actualizar su contraseña'}
      end
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
      :local_phone, :cell_phone, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at)
    end

    def update_params
      create_params
    end

    def normalized_params
      params.to_json
    end
end