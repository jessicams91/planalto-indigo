desc "Fetch product prices"
task fetch_prices_spellbox: :environment do
  require 'nokogiri'
  require 'open-uri'
  # Card.all.each do |card|
  card = Card.first
    expansion = card.expansion
    url = "http://www.spellbox.com.br/index.php?route=product/search&search=#{(card.name_en).gsub(' ', '%20')}+#{card.number}%2F#{expansion.card_total}"
    doc = Nokogiri::HTML(open(url))
    # if !(qtd = doc.at_css(".productListing-data:nth-child(6)")).nil?)
    if !(link = doc.at_css(".name a")).nil?
        puts link[:href]
        item = Nokogiri::HTML(open(url))
        price = item.at_css(".description+ .price").text.split("R$")[2].split('Dep').first
        # qtd = item.at_css("tr~ tr+ tr .description-right").text
        puts item.css(".description-right").text

      # qtd =  qtd.text.delete(' ')
      # price =  doc.at_css(".productListing-data:nth-child(3)").text.delete(' ').split("R$").last
      # shop_name = "Bazar Pokemon"
      # card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
      # card_price.update(shop_name: shop_name, card_link: link,
      #                   price: price, card: card, quantity: qtd)
    end
    # end
  # end
end
