class RemoveMedicineIdFromRecipeDetail < ActiveRecord::Migration[5.2]
  def up
  	remove_column :recipe_details, :medicine_id
  end

  def down
  end
end
