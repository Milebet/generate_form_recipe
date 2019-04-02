class AddAttributesToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :document_type, :string
    add_column :doctors, :document, :string
    add_column :doctors, :first_name, :string
    add_column :doctors, :second_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :second_last_name, :string
    add_column :doctors, :married_name, :string
    add_column :doctors, :birth_date, :date
    add_column :doctors, :genre, :string
    add_column :doctors, :local_phone, :string
    add_column :doctors, :cell_phone, :string
    add_column :doctors, :country, :string
    add_column :doctors, :city, :string
    add_column :doctors, :address, :text
    add_column :doctors, :speciality, :string
    add_column :doctors, :years_experience, :string
    add_column :doctors, :photo, :string
  end
end
