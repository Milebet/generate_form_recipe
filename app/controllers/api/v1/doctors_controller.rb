class Api::V1::DoctorsController < Api::V1::BaseController
	#before_action :load_resource
  #skip_before_action :authenticate_doctor!, only: [:index, :show, :create, :activate]
  #before_action :authenticate_doctor, only: [:index, :show]

  def index
    auth_doctors = policy_scope(@doctors)

    #render jsonapi: auth_doctors.collection,
    #  each_serializer: Api::V1::DoctorSerializer,
    #  fields: {doctor: auth_doctors.fields(params[:fields])},
    #  meta: meta_attributes(auth_doctors.collection)
  end

  def show
    auth_doctor = authorize_with_permissions(@doctor)

    render plain: ({doctor: auth_doctor.record, serializer: Api::V1::doctorserializer,
      fields: {doctor: auth_doctor.fields}}).to_json
  end
end