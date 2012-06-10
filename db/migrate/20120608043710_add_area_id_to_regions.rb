class AddAreaIdToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :area_id, :integer

  end
end
