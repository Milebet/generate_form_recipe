class RemoveRecipeIdFromRecipeDetail < ActiveRecord::Migration[5.2]
  def up
  	remove_column :recipe_details, :recipe_id
  end

  def down
  end
end
