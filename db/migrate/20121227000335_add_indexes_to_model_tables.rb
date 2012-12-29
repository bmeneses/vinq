class AddIndexesToModelTables < ActiveRecord::Migration
  def change
  	add_index :appellations, 				:region_id
  	add_index :product_attributes, 	:wine_id
  	add_index :regions, 						:area_id
  	add_index :wines, 							:appellation_id
  	add_index :wines,								:varietal_id
  	add_index :wines,								:product_attribute_id
  	add_index :wines,								:region_id
  end
end
