class Card < ActiveRecord::Base
  belongs_to :expansion
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      card_hash = row.to_hash
      card = find_by_id(row["id"]) || new
      card.expansion = Expansion.find_by_name_en(row["expansion"])
      if card_hash.fetch("number")
        card.attributes = card_hash.except("expansion")
        card.number = card.number.split('/')[0]
        card.name_en = card.name_en.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
        card.save!
      end
    end
  end
end
