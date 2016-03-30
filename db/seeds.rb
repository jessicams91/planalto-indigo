require 'csv'
CSV.foreach('db/roaring-skies.csv') do |row|
  Card.create(number: row[0].split('/')[0], name_en: row[1], element: row[2], rarity: row[3], expansion: "Roaring Skies")
end
File.foreach('db/roaring-skies_pt.txt').with_index do |line|
  row = line.split(/(\d+)/)
  card = Card.find_by(number: row[1], expansion: "Roaring Skies")
  card.update(name_pt: row[2].strip)
end
