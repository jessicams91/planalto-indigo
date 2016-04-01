# CSV.foreach('db/roaring-skies.csv') do |row|
#   Card.create(number: row[0].split('/')[0], name_en: row[1], element: row[2], rarity: row[3], expansion: "Roaring Skies")
# end
# # Update card names in portuguese from copag txt
# File.foreach('db/roaring-skies_pt.txt').with_index do |line|
#   row = line.split(/(\d+)/)
#   card = Card.find_by(number: row[1], expansion: "Roaring Skies")
#   card.update(name_pt: row[2].strip)
# end
# # Saving images from serebii
# Card.all.each do |card|
#   url = "http://www.serebii.net/card/"
#   expansion = card.expansion.delete(' ').downcase
#   photo = url+expansion+"/"+card.number+".jpg" if !card.photo
#   card.update(photo: photo)
# end
# # Change to pokemon.com for ex1+
# # http://assets.pokemon.com/assets/cms2/img/cards/web/XY6/XY6_EN_1.png
