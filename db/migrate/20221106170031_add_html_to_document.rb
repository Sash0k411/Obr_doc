class AddHtmlToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :html, :text
  end
end
