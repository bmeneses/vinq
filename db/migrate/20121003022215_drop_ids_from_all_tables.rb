class DropIdsFromAllTables < ActiveRecord::Migration
	def change
		remove_column :areas, :area_id
		remove_column :product_attributes, :product_attribute_id
		remove_column :regions, :region_id
		remove_column :varietals, :varietal_id
		remove_column :wines, :wine_id
	end

end
