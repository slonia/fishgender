class AddTagsToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :tags, :text
  end
end
