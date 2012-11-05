class AddIdPkToProductsAttrWines < ActiveRecord::Migration
  def change
  	add_column :product_attributes_wines, :id, :primary_key
  	add_column :product_attributes_wines, :created_at, :datetime
  	add_column :product_attributes_wines, :updated_at, :datetime
  	remove_index :product_attributes_wines, name: :idx_wines_product_attributes
  	add_index :product_attributes_wines,
  						[:product_attribute_id, :wine_id], 
  						unique: true,
  						name: :idx_wines_product_attributes
  end
end
