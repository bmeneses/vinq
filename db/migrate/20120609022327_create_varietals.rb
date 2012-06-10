class CreateVarietals < ActiveRecord::Migration
  def change
    create_table :varietals do |t|
      t.integer :varietal_id
      t.string :name
      t.string :url
      t.integer :winetype_id

      t.timestamps
    end
  end
end
