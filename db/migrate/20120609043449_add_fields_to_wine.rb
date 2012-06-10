class AddFieldsToWine < ActiveRecord::Migration
  def change
    add_column :wines, :varietal_id, :integer

    add_column :wines, :price_min, :decimal

    add_column :wines, :price_max, :decimal

    add_column :wines, :price_retail, :decimal

  end
end
