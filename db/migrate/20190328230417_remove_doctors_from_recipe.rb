class RemoveDoctorsFromRecipe < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :doctors, :recipe
  end
end
