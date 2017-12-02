class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :image
      t.integer :used, null: false, default: 0

      t.timestamps
    end
  end
end
