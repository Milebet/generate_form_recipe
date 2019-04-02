class AddAttributesToRecipeDetail < ActiveRecord::Migration[5.2]
  def up
    add_column :recipe_details, :medicine_name, :string
    add_column :recipe_details, :quantity, :string
    add_column :recipe_details, :indications, :string
  end

  def down
    remove_column :recipe_details, :medicine_name
    remove_column :recipe_details, :quantity
    remove_column :recipe_details, :indications
  end
end
