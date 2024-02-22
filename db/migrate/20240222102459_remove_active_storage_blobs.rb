class RemoveActiveStorageBlobs < ActiveRecord::Migration[7.1]
  def change
    drop_table :active_storage_blobs
  end
end
