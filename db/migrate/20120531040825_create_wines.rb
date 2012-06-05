class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :product_id
      t.string :name
      t.string :url
      t.string :type
      t.string :year

      t.timestamps
    end
  end
end
