class RemoveRecipeFromDoctors < ActiveRecord::Migration[5.2]
  def up
  	remove_reference :recipe, :doctor
  end

end
