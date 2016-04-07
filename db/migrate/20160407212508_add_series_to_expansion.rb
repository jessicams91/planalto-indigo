class AddSeriesToExpansion < ActiveRecord::Migration
  def change
    add_column :expansions, :series, :string
  end
end
