class AddProductAttributeIdToWines < ActiveRecord::Migration
  def change
    add_column :wines, :product_attribute_id, :integer
  end
end
