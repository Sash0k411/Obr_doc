class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.string :seo_title
      t.text :seo_description
      t.text :seo_keywords

      t.timestamps
    end
  end
end
