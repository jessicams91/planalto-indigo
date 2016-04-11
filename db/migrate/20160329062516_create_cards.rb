class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name_en
      t.string :name_pt
      t.string :card_type
      t.string :type_element
      t.string :rarity
      t.string :number
      t.string :expansion
      t.string :photo

      t.timestamps null: false
    end
  end
end
