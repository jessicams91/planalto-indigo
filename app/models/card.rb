class Card < ActiveRecord::Base
  belongs_to :expansion
  has_one :price
  def self.import(file)
    CSV.foreach(file.path, headers: true, skip_blanks: true) do |row|
      card_hash = row.to_hash
      expansion = Expansion.find_by_name_en(row["expansion"])
      card = find_by_id(row["id"]) || new
      card.attributes = card_hash.except("expansion")
      card.expansion = expansion
      card.save!
      format_fields(card)
    end
  end

  def self.format_fields(card)
    name_en = card.name_en.gsub(/(?<=[a-z])(?=[A-Z])/, ' ').gsub('Mega ','M ')
    number = card.number.split('/')[0].strip
    rarity = card.rarity.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
    arr = @@type_map.assoc(card.type_element)
    if arr.nil?
      card.update(number:number, name_en:name_en, rarity: rarity, card_type: "Na")
    else
      card.update(number:number, name_en:name_en, rarity: rarity,
                  type_element: arr[1], card_type: arr[2])
    end
  end

  @@type_map = [
    ["I","Item","Trainer"],
    ["Su","Supporter","Trainer"],
    ["St","Stadium","Trainer"],
    ["T","Trainer","Trainer"]
  ]
end
