desc "Fetch product prices"
task bazar_pokemon: :environment do
  require 'nokogiri'
  require 'mechanize'
  shop_name = "Bazar Pokemon"
  deleted = updated = new = not_found = 0
  cards = Card.where("expansion_id >= 50")
  # cards.each do |card|
  card = Card.find(5829)
    card_expansion = card.expansion
    card_name = card.name_en.gsub('é','e').tr("^A-Za-z0-9-. ", ' ')
    url = "http://bazarpokemon.com/loja/advanced_search_result.php?keywords=#{card_name} #{card.number}"
    agent = Mechanize.new
    agent.get(url)
    doc = agent.page
    [0,1].each do |id|
      link = doc.css(".productListing-data+ .productListing-data a")[id]
      if link
        name = link.text
        # binding.pry
        link = link[:href]
        qtd = doc.css(".productListing-data:nth-child(6)")[id].text.delete(' ')
        price = doc.css(".productListing-data:nth-child(3)")[id].text.delete(' ').split("R$").last
        if name.include?("Reverse Foil")
          card_price = CardPrice.find_by(card: card, shop_name: shop_name, foil:true) || CardPrice.new
          p "TRUE #{card_price.id}"
          foil = true
        else
          card_price = CardPrice.find_by(card: card, shop_name: shop_name, foil:false) || CardPrice.new
          p "FALSE #{card_price.id}"
          foil = false
        end
        if card_price.id?
          card_price.update(price: price, quantity: qtd)
          updated+=1
          puts "#{card.id} #{card.name_en} #{card.number} #{foil} #{card_price.id} Atualizado"
        else
          card_price.update(shop_name: shop_name, card_link: link, card: card, price: price, quantity: qtd, foil:foil)
          new+=1
          puts "#{card.id} #{card.name_en} #{card.number} #{foil} #{card_price.id} Novo"
        end
      else
        puts "#{card.id} #{card.name_en} #{card.number} Não Encontrado!"
        not_found+=1
        # binding.pry
        # if card_price.id?
        #   card_price.destroy
        #   deleted+=1
        #   puts "#{card.id} #{card.name_en} #{card.number} Deletado"
        # end
      end
    end
  # end
  puts "Deletados: #{deleted} Atualizados: #{updated}  Novos: #{new}"
end
