class AddStreetToCmps < ActiveRecord::Migration[5.2]
  def change
    add_column :cmps, :street, :string
  end
end
