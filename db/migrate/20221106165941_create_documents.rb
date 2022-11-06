class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|

      t.string :title
      t.string :slug
      t.text :description
      t.integer :year
      t.datetime :date

      t.string :seo_title
      t.text :seo_description
      t.text :seo_keywords

      t.integer :category_id, index: true
      t.timestamps
    end
  end
end
