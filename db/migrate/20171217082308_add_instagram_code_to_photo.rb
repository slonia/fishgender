class AddInstagramCodeToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :instagram_code, :string
  end
end
