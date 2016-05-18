class AddFoilToCardPrice < ActiveRecord::Migration
  def change
    add_column :card_prices, :foil, :boolean, default: false
  end
end
