class AddVerifiedToSignup < ActiveRecord::Migration[5.2]
  def change
    add_column :signups, :verified, :string
  end
end
