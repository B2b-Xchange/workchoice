class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :type
      t.integer :channel
      t.integer :billing_type
      t.integer :scope_hours
      t.text :title
      t.text :remarks
      t.text :scope_of_work
      t.text :scope_of_experience
      t.date :start_date
      t.date :end_date
      t.integer :hourly_payment
      t.integer :currency
      t.bit :anonymous
      t.references :address, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:type, :channel, :created_at]
  end
end
