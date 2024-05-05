class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :brand
      t.string :price
      t.string :landing_image
      t.jsonb :images
      t.text :description
      t.text :url

      t.timestamps
    end
  end
end
