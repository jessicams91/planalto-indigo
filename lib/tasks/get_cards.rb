require 'csv'
CSV.foreach('db/roaring-skies.csv') do |row|
  Card.create(number: row[0].split('/')[0], name_en: row[1], element: row[2], rarity: row[3], expansion: "Roaring Skies")
end
