class CreateRecipeDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_details do |t|
      t.integer :recipe_id
      t.integer :medicine_id

      t.timestamps
    end
  end
end
