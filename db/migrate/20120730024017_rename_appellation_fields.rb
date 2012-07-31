class RenameAppellationFields < ActiveRecord::Migration
	def change
		rename_column :appellations, :appelation_id, :appellation_id
	end

end
