class CreateWinesProductAttributesJoinTable < ActiveRecord::Migration
 def change
  # who knew this had to be in alphabetical order?
  create_table :product_attributes_wines, id: false do |t|
    t.integer :product_attribute_id
    t.integer :wine_id
  end
  add_index :product_attributes_wines, [:product_attribute_id, :wine_id],
            name: 'idx_wines_product_attributes'
 end
end
