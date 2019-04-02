class AddRecipesToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipes, :doctors, foreign_key: true
  end
end
