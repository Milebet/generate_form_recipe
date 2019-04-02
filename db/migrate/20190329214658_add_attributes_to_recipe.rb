class AddAttributesToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :full_name, :string
    add_column :recipes, :email, :string
    add_column :recipes, :cell_phone, :string
    add_column :recipes, :local_phone, :string
  end
end
