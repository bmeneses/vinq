class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :product_attributes do |t|
      t.integer :product_attribute_id
      t.integer :wine_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
