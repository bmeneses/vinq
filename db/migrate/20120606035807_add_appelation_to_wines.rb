class AddAppelationToWines < ActiveRecord::Migration
  def change
    add_column :wines, :appelation_id, :integer

  end
end
