desc "Fetch product prices"
task bazar_pokemon: :environment do
  require 'nokogiri'
  require 'mechanize'
  shop_name = "Bazar Pokemon"
  initial_expansion = "Black White"
  id = Expansion.find_by_name_en(initial_expansion).id
  cards = Card.where("expansion_id >= #{id}")
  cards.each do |card|
    card_expansion = card.expansion
    url = "http://bazarpokemon.com/loja/advanced_search_result.php?keywords=#{(card.name_en).gsub(' ', '+').tr('^A-Za-z0-9', '')}+#{card.number}%2F#{card_expansion.card_total}"
    agent = Mechanize.new
    agent.get(url)
    doc = agent.page
    qtd = doc.at_css(".productListing-data:nth-child(6)")
    expansion = doc.at_css(".productListing-data:nth-child(5)")
    card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
    if qtd.nil? || qtd.text.delete(' ') == 0 || expansion.text.delete(' ') != card_expansion.prefix.upcase
      if card_price.id?
        card_price.destroy
        puts "#{card.id} Deletado"
      end
    else
      qtd =  qtd.text.delete(' ')
      price =  doc.at_css(".productListing-data:nth-child(3)").text.delete(' ').split("R$").last
      link = doc.at_css(".productListing-data+ .productListing-data a")[:href]
      if card_price.id?
        card_price.update(price: price, card: card, quantity: qtd)
      else
        card_price.update(shop_name: shop_name, card_link: link, card: card, price: price, quantity: qtd)
      end
      puts "#{card.id} - #{card.expansion.prefix} OK"
    end
  end
end
