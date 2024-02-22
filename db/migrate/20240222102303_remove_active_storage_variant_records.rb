class RemoveActiveStorageVariantRecords < ActiveRecord::Migration[7.1]
  def change
    drop_table :active_storage_variant_records
  end
end
