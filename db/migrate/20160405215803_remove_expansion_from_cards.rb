class RemoveExpansionFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :expansion, :string
  end
end
