class DropPatients < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :recipes, :patient
  	drop_table :patients
  end
end
