class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :postcode
      t.string :country
      t.string :phone_number
      t.string :web_address

      t.timestamps
    end
  end
end
