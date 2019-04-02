class TokenNotNullDoctors < ActiveRecord::Migration[5.2]
  def up
  	change_column_null :doctors, :token, false
  end
end
