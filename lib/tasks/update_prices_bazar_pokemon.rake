desc "Fetch product prices"
task bazar_pokemon: :environment do
  require 'nokogiri'
  require 'open-uri'
  Card.all.each do |card|
    expansion = card.expansion
    url = "http://bazarpokemon.com/loja/advanced_search_result.php?keywords=#{(card.name_en).gsub(' ', '+')}+#{card.number}%2F#{expansion.card_total}"
    doc = Nokogiri::HTML(open(url))
    if !(qtd = doc.at_css(".productListing-data:nth-child(6)")).nil? && !(qtd.text.delete(' ') == 0)
      qtd =  qtd.text.delete(' ')
      price =  doc.at_css(".productListing-data:nth-child(3)").text.delete(' ').split("R$").last
      link = doc.at_css(".productListing-data+ .productListing-data a")[:href]
      shop_name = "Bazar Pokemon"
      card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
      if card_price.shop_name.nil?
        card_price.update(shop_name: shop_name, card_link: link,
                          price: price, card: card, quantity: qtd)
      else
        card_price.update(price: price, card: card)
      end
    end
  end
end
