class Card < ActiveRecord::Base
  belongs_to :expansion
  has_one :price
  def self.import
  # def self.import(file)
    # CSV.foreach(file.path, headers: true, skip_blanks: true) do |row|
    CSV.foreach('cards.csv', headers: true, skip_blanks: true) do |row|
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
    name_en = card.name_en
    name_en = name_en.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
    name_en = name_en.gsub('Mega ','M ') if card.name_en.include?("EX")
    number = card.number.strip
    rarity = card.rarity.gsub(/(?<=[a-z])(?=[A-Z])/, ' ')
    if card.card_type.nil?
      arr = @@type_map.assoc(card.type_element)
      if card.type_element.ends_with? "E"
        type_element = card.type_element.gsub(" E","")
        card.update(number:number, name_en:name_en, rarity: rarity,
                    type_element: type_element, card_type: "Energy")
      elsif arr.nil?
        card.update(number:number, name_en:name_en, rarity: rarity,
                    card_type: "Pokémon")
      else
        card.update(number:number, name_en:name_en, rarity: rarity,
                    type_element: arr[1], card_type: arr[2])
      end
    end
  end

  @@type_map = [
    ["I","Item","Trainer"],
    ["Su","Supporter","Trainer"],
    ["St","Stadium","Trainer"],
    ["T","Trainer","Trainer"],
    ["T [GC]","Goldenrod Game Corner","Trainer"],
    ["T [R]","Trainer","Trainer"],
    ["T [St]","Stadium","Trainer"],
    ["T [Su]","Supporter","Trainer"],
    ["T [TM]","TM","Trainer"],
    ["T [Tool]","Tool","Trainer"]
  ]
end
