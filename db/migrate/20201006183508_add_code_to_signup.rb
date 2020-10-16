class AddCodeToSignup < ActiveRecord::Migration[5.2]
  def change
    add_column :signups, :code, :string
  end
end
