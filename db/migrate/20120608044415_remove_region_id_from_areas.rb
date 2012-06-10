class RemoveRegionIdFromAreas < ActiveRecord::Migration
  def up
    remove_column :areas, :region_id
  end

  def down
    add_column :areas, :region_id, :integer
  end
end
