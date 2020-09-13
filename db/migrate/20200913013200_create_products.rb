class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :cost_price, null: false

      t.timestamps
    end
  end
end
