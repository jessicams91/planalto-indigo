class CreateExpansions < ActiveRecord::Migration
  def change
    create_table :expansions do |t|
      t.string :name_en
      t.string :name_pt
      t.integer :card_total
      t.string :prefix
      t.string :series
      t.string :icon
      t.string :expansion_link

      t.timestamps null: false
    end
  end
end
