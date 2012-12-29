class RenameApelationToAppellation < ActiveRecord::Migration
  def change
  	rename_table :apellations, :appellations
  end
end
	
