class AddRecipeToRecipeDetail < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipe_details, :recipe, foreign_key: true
  end
end
