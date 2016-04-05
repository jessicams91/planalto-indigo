class AddExpansionToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :expansion, index: true, foreign_key: true
  end
end
