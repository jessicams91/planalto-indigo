File.foreach('db/roaring-skies.txt').with_index do |line|
  att = line.split
  Card.create(number: att[0].split('/')[0], name_en: att[1], card_type: att[2], rarity: att[3], expansion: "Roaring Skies")
end
File.foreach('db/roaring-skies_pt.txt').with_index do |line|
  att = line.split
  card = Card.find_by(number: att[0], expansion: "Roaring Skies")
  card.update(name_pt: att[1])
end
