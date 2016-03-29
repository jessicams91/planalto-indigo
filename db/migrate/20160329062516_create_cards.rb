class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name_en
      t.string :name_pt
      t.string :stage
      t.string :card_type
      t.integer :hit_points
      t.string :rarity
      t.string :number
      t.string :expansion
      t.string :photo
      t.string :weakness
      t.string :resistance
      t.string :retreat_cost

      t.timestamps null: false
    end
  end
end
