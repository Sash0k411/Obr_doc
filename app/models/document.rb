class Document < ApplicationRecord
    self.table_name = :files
    mount_uploader :file, ::FileUploader
end
