class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :document_type
      t.string :document
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :cell_phone
      t.string :local_phone

      t.timestamps
    end
  end
end
