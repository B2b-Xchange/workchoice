class ChangeTypeToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.rename :type, :content_type
    end
  end
end
