class AddLatitudeToCmps < ActiveRecord::Migration[5.2]
  def change
    add_column :cmps, :name, :string
    add_column :cmps, :city, :string
    add_column :cmps, :latitude, :float
    add_column :cmps, :longitude, :float
  end
end
