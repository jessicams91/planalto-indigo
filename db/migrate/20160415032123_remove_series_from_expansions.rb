class RemoveSeriesFromExpansions < ActiveRecord::Migration
  def change
    remove_column :expansions, :series, :string
  end
end
