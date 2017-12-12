class AddActiveToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :active, :boolean, default: true, null: false
  end
end
