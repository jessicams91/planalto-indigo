class AddColumnsToExpansions < ActiveRecord::Migration
  def change
    add_column :expansions, :icon, :string
    add_column :expansions, :expansion_link, :string
  end
end
