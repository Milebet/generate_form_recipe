class AddPatientToRecipes < ActiveRecord::Migration[5.2]
  def up
    add_reference :recipes, :patient, foreign_key: true
  end

  def down
    remove_reference :recipes, :patient
  end
end
