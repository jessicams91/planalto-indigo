require 'nokogiri'
require 'mechanize'
desc "Fetch product prices for Bazar de Bagdá"
task bazar_bagda: :environment do
  shop_name = "Bazar de Bagdá"
  deleted = updated = new = not_found = 0
  cards = Card.where("expansion_id >= 60")
  puts "Starting update for #{cards.count} cards"
  cards.each do |card|
    # Starting Attributtes
    card_total = card.expansion.cards.count
    card_name = card.name_en.tr("^A-Za-z0-9-é'. ", ' ').gsub(" EX","-EX")
    base_url = "http://www.bazardebagda.com.br/?view=ecom%2Fitens&id=56925&busca="
    case card.expansion.id
    when 68,70
      url = base_url+"#{card_name} (%23#{card.number})"
    else
      card_number = card.number.split('/')[0]
      url = base_url+"#{card_name} (%23#{card_number}/#{card_total})"
    end
    # Accessing page
    agent = Mechanize.new
    agent.get(url)
    doc = agent.page
    # Update CardPrice
    card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
    begin
      # Get page attributes
      qtd = doc.at_css(".hmin30:nth-child(4)").text.strip.split[0]
      price = doc.at_css(".itemPreco").text.split[1].gsub(',','.') unless qtd.eql? "0"
      link = doc.uri.to_s
      if card_price.id?
        card_price.update(price: price, quantity: qtd, shop_name: shop_name)
        updated+=1
        puts "#{card.id} #{card.name_en} Atualizado"
      else
        card_price.update(shop_name: shop_name, card_link: link, card: card,
                          price: price, quantity: qtd)
        new+=1
        puts "#{card.id} #{card.name_en} Novo"
      end
    rescue
      puts "#{card.id} #{card.name_en} #{card_number} Não Encontrado!"
      not_found+=1
      if card_price.id?
        card_price.destroy
        deleted+=1
        puts "#{card.id} #{card.name_en} Deletado"
      end
    end
  end
  puts "Deletados: #{deleted} Atualizados: #{updated} Não Localizados: #{not_found}  Novos: #{new}"
end
