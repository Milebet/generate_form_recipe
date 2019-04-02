class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  type :session

  attributes :email, :token, :doctor_id

  has_one :doctor, serializer: Api::V1::DoctorSerializer do
    link(:self) {api_v1_doctor_path(object.id)}
    link(:related) {api_v1_doctor_path(object.id)}
    object
  end

  def doctor
    object
  end

  def doctor_id
    object.id
  end

  def token
    object.token
  end

  def email
    object.email
  end
end