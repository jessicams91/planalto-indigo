class CreateExpansions < ActiveRecord::Migration
  def change
    create_table :expansions do |t|
      t.string :name_en
      t.string :name_pt
      t.integer :card_total
      t.string :prefix

      t.timestamps null: false
    end
  end
end
