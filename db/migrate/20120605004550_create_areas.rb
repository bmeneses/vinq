class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :area_id
      t.string :name
      t.string :url
      t.integer :region_id

      t.timestamps
    end
  end
end
