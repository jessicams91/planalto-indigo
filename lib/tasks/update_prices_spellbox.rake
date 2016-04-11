desc "Fetch product prices"
task spellbox: :environment do
  require 'nokogiri'
  require 'mechanize'
  agent = Mechanize.new
  shop_name = "Spellbox"
  Card.all.each do |card|
  # Card.where('expansion_id = 69').each do |card|
    expansion = card.expansion
    card_price = CardPrice.find_by(card: card, shop_name: shop_name) ||   CardPrice.new
    if card_price.card_link.nil?
      url = "http://www.spellbox.com.br/index.php?route=product/search&search=#{card.name_en.delete("'").tr('^A-Za-z0-9', ' ')} #{card.number} #{expansion.name_en}"
      agent.get(url)
      doc = agent.page
      link = doc.at_css(".name a")
      card_link = link[:href] unless link.nil?
    else
      card_link = card_price.card_link
    end
    unless link.nil?
    item = agent.get(card_link)
    qtd = item.at_css("tr~ tr+ tr .description-right")
      qtd = qtd.text
      price = item.at_css(".description+ .price").text.split('R$').last
      if card_price.id?
       card_price.update(price: price, card: card, quantity: qtd)
       puts "#{card.id} preço atualizado"
      else
       card_price.update(shop_name: shop_name, card_link: card_link, card: card, price: price, quantity: qtd)
       puts "#{card.id} Novo preço"
      end
      card_price.update(price: price, card: card)
    end
  end
end
