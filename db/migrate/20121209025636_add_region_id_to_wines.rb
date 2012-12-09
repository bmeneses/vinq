class AddRegionIdToWines < ActiveRecord::Migration
  def change
    add_column :wines, :region_id, :integer

  end
end
