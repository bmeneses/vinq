class CreateGeolocations < ActiveRecord::Migration
  def change
    create_table :geolocations do |t|
      t.float :lat
      t.float :long
      t.string :url

      t.timestamps
    end
  end
end
