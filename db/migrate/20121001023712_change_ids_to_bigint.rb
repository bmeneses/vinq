class ChangeIdsToBigint < ActiveRecord::Migration
	def change
		change_column :appellations, :id, :bigint
		change_column :appellations, :region_id, :bigint
		remove_column :appellations, :appellation_id	

		# change_column :areas, :id, :bigint
		# remove_column :areas, :area_id, :bigint

		# change_column :geolocations, :id, :bigint
		# remove_column :geolocations, :geolocation_id, :bigint

		# change_column :areas, :id, :bigint
		# remove_column :areas, :area_id, :bigint

	end


end
