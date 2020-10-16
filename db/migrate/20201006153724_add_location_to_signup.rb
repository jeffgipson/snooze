class AddLocationToSignup < ActiveRecord::Migration[5.2]
  def change
    add_reference :signups, :location, foreign_key: true
  end
end
