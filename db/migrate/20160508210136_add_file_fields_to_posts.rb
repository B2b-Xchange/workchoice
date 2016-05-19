class AddFileFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :picture, :string
    add_column :posts, :document, :string
  end
end
