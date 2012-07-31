class RenamingAppelationRefFields < ActiveRecord::Migration
	def change
		rename_column :wines, :appelation_id, :appellation_id
	end

end
