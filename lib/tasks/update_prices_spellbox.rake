# desc "Fetch product prices"
# task fetch_prices_spellbox: :environment do
#   require 'nokogiri'
#   require 'open-uri'
#   Card.all.each do |card|
#     expansion = card.expansion
#     url = "http://www.spellbox.com.br/index.php?route=product/search&search=#{(card.name_en.delete("'"))} #{card.number}/#{expansion.card_total}"
#     doc = Nokogiri::HTML(open(url))
#     if !(link = doc.at_css(".name a")).nil?
#       card_link = link[:href]
#       price = doc.at_css(".price-new").text.delete("R$").gsub(',','.')
#
#       item = Nokogiri::HTML(open(card_link))
#       qtd = item.css("tr~ tr+ tr .description-right").text
#       shop_name = "Spellbox"
#       card_price = CardPrice.find_by(card: card, shop_name: shop_name) ||
#                    CardPrice.new(shop_name: shop_name, card_link: link, card: card)
#       card_price.update(price: price, card: card)
#     end
#   end
# end
