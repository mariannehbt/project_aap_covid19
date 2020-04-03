class CreateCmps < ActiveRecord::Migration[5.2]
  def change
    create_table :cmps do |t|
      t.string :adress
      t.string :zipcode
      t.string :phonenumber

      t.timestamps
    end
  end
end
