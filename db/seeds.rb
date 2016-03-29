File.foreach('db/roaring-skies.txt').with_index do |line|
  att = line.split
  Card.create(number: att[0], name_en: att[1], card_type: att[2], rarity: att[3], expansion: "Roaring Skies")
end
