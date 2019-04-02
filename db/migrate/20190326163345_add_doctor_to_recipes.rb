class AddDoctorToRecipes < ActiveRecord::Migration[5.2]
  def up
    add_reference :recipes, :doctor, foreign_key: true
  end

  def down
    remove_reference :recipes, :doctor, foreign_key: true
  end
end
