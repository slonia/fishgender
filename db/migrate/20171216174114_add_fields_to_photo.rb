class AddFieldsToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :source, :integer, default: 0, null: false
    add_column :photos, :instagram_id, :string
  end
end
