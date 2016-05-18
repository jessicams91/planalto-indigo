class RemoveExpansionLinkFromExpansion < ActiveRecord::Migration
  def change
    remove_column :expansions, :expansion_link, :string
  end
end
