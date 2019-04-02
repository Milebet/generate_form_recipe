class AddTokenToDoctors < ActiveRecord::Migration[5.2]
  def up
    add_column :doctors, :token, :string
    Doctor.find_each{|doctor| doctor.save!}
  end

  def down
    remove_column :doctors, :token, :string
  end
end
