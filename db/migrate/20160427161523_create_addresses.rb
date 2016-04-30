class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :company
      t.string :street_name
      t.string :street_no
      t.string :zip
      t.string :city
      t.string :phone
      t.string :email
      t.string :contact_person
      t.string :vat_no
      t.string :country_iso_code
      t.string :website
      t.string :state
      t.integer :headcount
      t.text :scope_of_experience
      t.text :scope_of_work
      t.bit :display
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
