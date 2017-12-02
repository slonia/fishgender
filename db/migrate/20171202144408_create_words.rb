class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :used, null: false, default: 0

      t.timestamps
    end
  end
end
