class AddFingerprintToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :fingerprint, :string
  end
end
