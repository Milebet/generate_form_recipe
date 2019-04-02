class CreateJoinTableRecipeMedicine < ActiveRecord::Migration[5.2]
  def change
    create_join_table :recipes, :medicines do |t|
       t.index [:recipe_id, :medicine_id]
       t.index [:medicine_id, :recipe_id]
    end
  end
end
