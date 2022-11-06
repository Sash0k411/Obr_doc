class AddFileIdToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :file_id, :integer, index: true
  end
end
