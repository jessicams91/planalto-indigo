# desc "Fetch product prices"
# task fetch_prices_domain: :environment do
#   require 'nokogiri'
#   require 'open-uri'
#   require "watir"
#   browser = Watir::Browser.new
#   # Card.all.each do |card|
#     card = Card.first
#     expansion = card.expansion
#     url = "http://www.domaingames.com.br/Busca_Avancada.asp?q=#{(card.name_en.delete("'"))}"
#     http://www.domaingames.com.br/Ajax_Funcoes.asp?IsNovoCfg=true&Busca=Exeggcute&Funcao=BuscaAvancada
#     # browser.goto url
#     doc = Nokogiri::HTML.parse(browser.html)
#     # puts doc.css("div#card_name")
#     # if !(link = doc.at_css(".name a")).nil?
#     #   card_link = link[:href]
#     #   price = doc.at_css(".price-new").text.delete("R$").gsub(',','.')
#     #
#     #   item = Nokogiri::HTML(open(card_link))
#     #   qtd = item.css("tr~ tr+ tr .description-right").text
#     #   shop_name = "Spellbox"
#     #   card_price = CardPrice.find_by(card: card, shop_name: shop_name) ||
#     #                CardPrice.new(shop_name: shop_name, card_link: link, card: card)
#     #   card_price.update(price: price, card: card)
#     # end
#   # end
# end
