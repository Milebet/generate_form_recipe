class AddObservationsToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :observation, :text
  end
end
