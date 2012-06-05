class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :region_id
      t.string :name
      t.string :url
      t.integer :appelation_id

      t.timestamps
    end
  end
end
