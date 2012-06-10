class DeleteAppelationIdFrom < ActiveRecord::Migration
  def up
    remove_column :regions, :appelation_id
  end

  def down
    add_column :regions, :appelation_id, :integer
  end
end
