desc "Fetch product prices"
task spellbox: :environment do
  require 'nokogiri'
  require 'mechanize'
  agent = Mechanize.new
  shop_name = "Spellbox"
  puts 'Iniciando Update de Preços'
  expansions = [1,22,34,35,42,43,44]
  deleted = updated = new = 0
  cards = Card.where("expansion_id IN (?) OR expansion_id >= 46",expansions)
              .order(:id)
  cards.each do |card|
    expansion = card.expansion
    card_price = CardPrice.find_by(card: card, shop_name: shop_name) || CardPrice.new
    if card_price.card_link.nil?
      card_name = card.name_en.tr("^A-Za-z0-9-.é", ' ').strip
      expansion_name = expansion.name_en
      card_number = card.number
      card_number = case expansion.id
      when 1
        expansion_name = "Base Set 1st edition"
        card_name = card_name.gsub("Energy","")
        card.number.split('/')[0]
      when 22
        card_name = card_name.gsub("Rockets ","") if card_name.starts_with?("Rockets")
        ""
      when 42, 44, 47, 54
        case card.number
        when "TWO" then "96/95"
        when "SH10" then "100/#{expansion.card_total}"
        when "SH11" then "101/#{expansion.card_total}"
        when "SH12" then "102/#{expansion.card_total}"
        end
      when 67
        card_name = "Porygon 2" if card.name_en == "Porygon2"
        card_name = "Porygon Z" if card.name_en == "Porygon-Z"
        "%03d"%card.number.split('/')[0]
      when 56 then "#{card.number}/138"
      when 61
        expansion_name = "Flash de Fogo"
      when 49
        expansion_name = "Poderes Emergentes"
      when 35
        expansion_name = "Encounters"
      end
      card_number = "" if card_name.include?("Alph Lithograph")
      url = "http://www.spellbox.com.br/index.php?route=product/search&search=#{card_name} #{card_number} #{expansion_name}&description=true"
      agent.get(url)
      doc = agent.page
      link = doc.at_css(".name a")
      link2 = doc.css(".name a")[1]
    end
    if card_price.card_link?
      card_link = card_price.card_link
    else
      unless link.nil?
        card_link = link[:href]
        card_link = link2[:href] unless link2.nil? if card_link.include?("reverse-foil") || card_link.include?("-ancient-origins-")
      end
    end
    puts "#{card.id} #{card_name} #{card_number} #{expansion_name} Não Encontrado!" if card_link.nil?
    not_found+=1
    unless card_link.nil?
      item = agent.get(card_link)
      name = item.at_css(".fn").text.delete("'").tr('^A-Za-z0-9-.', ' ')
      qtd = item.at_css("tr+ tr .description-right").text
      price = item.at_css(".description+ .price").text.split('R$').last.gsub(',','.')
      if name.include?("Reverse Foil")
        puts "#{card.id} #{name} Errado!"
        if card_price.id?
          puts "#{card.id} #{name} Deletado"
          card_price.destroy
          deleted+=1
        end
      elsif card_price.id?
        card_price.update(price: price, quantity: qtd)
        # puts "#{card.id} #{name} Atualizado"
        updated+=1
      else
        card_price.update(shop_name: shop_name, card_link: card_link, card: card, price: price, quantity: qtd)
        # puts "#{card.id} #{name} Novo preço"
        new+=1
      end
    end
  end
  puts "Deletados: #{deleted} Atualizados: #{updated} Não Encontrados: #{not_found}s Novos: #{new}"
end
