class Card < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      card_hash = row.to_hash
      if card_hash.fetch("number")
        card = find_by_id(row["id"]) || new
        card.attributes = card_hash
        card.number = card.number.split('/')[0]
        card.save!
      end
    end
  end
end
