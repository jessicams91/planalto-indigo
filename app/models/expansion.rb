class Expansion < ActiveRecord::Base
  has_many :cards
  # def self.import(file)
  #   CSV.foreach(file.path, headers: true, skip_blanks: true) do |row|
  def self.import(file)
    CSV.foreach(file, headers: true, skip_blanks: true) do |row|
      expansion_hash = row.to_hash
      expansion = find_by_id(row["id"]) || new
      expansion.attributes = expansion_hash
      expansion.save!
    end
  end
end
