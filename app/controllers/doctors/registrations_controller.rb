# frozen_string_literal: true

class Doctors::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
     @resource = Doctor.new
   end

  # POST /resource
   def create
    @generated_password = Devise.friendly_token.first(6)
    @resource = Doctor.create(configure_sign_up_params)
    @resource.password = @generated_password
    #@resource.user.activate
    respond_to do |format|
      if @resource.save
        RecipeMailer.welcome_doctor(@resource, @generated_password).deliver_now
        format.html { redirect_to profile_doctor_url(@resource), notice: "Doctor creado" }
      else
        flash.now[:alert] = "Error #{@resource.errors.keys}"
        format.html { render action: "new", :alert => "fallos" }
      end
    end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     params.require(:doctor).permit(:email, :password, :password_confirmation, :document_type, 
      :document, :first_name, :second_name, :last_name, :second_last_name, :married_name, 
      :birth_date, :genre, :speciality, :years_experience, :country, :city, :address, 
      :local_phone, :cell_phone, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at)
     #devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :speciality, :document_type,
     # :document, :first_name, :second_name, :last_name, :second_last_name, :married_name,
     # :birth_date, :genre, :photo, :cell_phone, :local_phone, :country, :city, :address,
     # :years_experience, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :document_type, 
      :document, :first_name, :second_name, :last_name, :second_last_name, :married_name, 
      :birth_date, :genre, :speciality, :years_experience, :country, :city, :address, 
      :local_phone, :cell_phone, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at])
   end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
