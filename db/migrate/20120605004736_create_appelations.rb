class CreateAppelations < ActiveRecord::Migration
  def change
    create_table :appelations do |t|
      t.integer :appelation_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
