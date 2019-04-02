class Api::V1::DoctorSerializer < ActiveModel::Serializer
  attributes(*Doctor.attribute_names.map(&:to_sym))

  has_many :recipes, serializer: Api::V1::DoctorSerializer do
    include_data(false)
    link(:related) {api_v1_doctor_recipes_path(doctor_id: object.id)}
  end
end