class RemoveTypeFromWines < ActiveRecord::Migration
  def change
		rename_column :wines, :type, :wine_type
  end


end
