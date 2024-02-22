class RemoveActiveStorageAttachments < ActiveRecord::Migration[7.1]
  def change
    drop_table :active_storage_attachments
  end
end
