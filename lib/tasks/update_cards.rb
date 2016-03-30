File.foreach('db/roaring-skies_pt.txt').with_index do |line|
  row = line.split(/(\d+)/)
  card = Card.find_by(number: row[1], expansion: "Roaring Skies")
  card.update(name_pt: row[2].strip)
end
