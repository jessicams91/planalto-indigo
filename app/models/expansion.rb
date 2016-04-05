class Expansion < ActiveRecord::Base
  has_many :cards
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      expansion_hash = row.to_hash
      expansion = find_by_id(row["id"]) || new
      expansion.attributes = expansion_hash
      expansion.save!
    end
  end
end
