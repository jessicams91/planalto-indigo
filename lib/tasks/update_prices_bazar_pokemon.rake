desc "Fetch product prices"
task bazar_pokemon: :environment do
  require 'nokogiri'
  require 'mechanize'
  shop_name = "Bazar Pokemon"
  deleted = updated = new = 0
  cards = Card.where("expansion_id >= 50")
  cards.each do |card|
    card_expansion = card.expansion
    if !/\A\d+\z/.match(card.number)
      card_number = "#{card.number}/"
    else
      card_number = "#{card.number}/#{card_expansion.card_total}"
    end
    card_name = card.name_en.gsub('é','e').tr("^A-Za-z0-9-. ", ' ')
    url = "http://bazarpokemon.com/loja/advanced_search_result.php?keywords=#{card_name} #{card_number}"
    agent = Mechanize.new
    agent.get(url)
    doc = agent.page
    qtd = doc.at_css(".productListing-data:nth-child(6)")
    expansion = doc.at_css(".productListing-data:nth-child(5)")
    card_prefix = case card_expansion.prefix
      when 'xy2' then 'XY 2'
      when 'dc1' then 'DC'
      when 'xy1' then 'XY'
      when 'dv1' then 'Dragon Vault'
      when 'gen1' then 'Generations'
      else card_expansion.prefix.upcase
    end
    card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
    if qtd.nil?
      puts "#{card.id} #{card.name_en} #{card_number} #{card_prefix} Não Encontrado!"
      if card_price.id?
        card_price.destroy
        deleted+=1
        puts "#{card.id} #{card.name_en} Deletado"
      end
    else
      qtd =  qtd.text.delete(' ')
      price =  doc.at_css(".productListing-data:nth-child(3)").text.delete(' ').split("R$").last
      link = doc.at_css(".productListing-data+ .productListing-data a")[:href]
      if card_price.id?
        card_price.update(price: price, quantity: qtd)
        updated+=1
        # puts "#{card.id} #{card.name_en} Atualizado"
      else
        card_price.update(shop_name: shop_name, card_link: link, card: card, price: price, quantity: qtd)
        new+=1
        puts "#{card.id} #{card.name_en} Novo"
      end
    end
  end
  puts "Deletados: #{deleted} Atualizados: #{updated}   Novos: #{new}"
end
