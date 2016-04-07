class CreateCardPrices < ActiveRecord::Migration
  def change
    create_table :card_prices do |t|
      t.string :shop_name
      t.string :card_link
      t.integer :quantity
      t.decimal :price
      t.references :card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
