class AddRegionIdToAppelations < ActiveRecord::Migration
  def change
    add_column :appelations, :region_id, :integer
  end
end
