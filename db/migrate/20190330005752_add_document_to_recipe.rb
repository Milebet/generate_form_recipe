class AddDocumentToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :document_type, :string
    add_column :recipes, :document, :string
  end
end
