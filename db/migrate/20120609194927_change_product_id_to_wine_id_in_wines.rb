class ChangeProductIdToWineIdInWines < ActiveRecord::Migration
  def change
    rename_column :wines, :product_id, :wine_id
  end

end
