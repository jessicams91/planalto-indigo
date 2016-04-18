desc "Fetch Cards images"
task update_cards_img: :environment do
  require 'nokogiri'
  require 'mechanize'
  cards = Card.where(photo: nil)
  not_found = new_img = 0
  cards.each do |card|
    card_expansion = card.expansion
    expansion_name = card_expansion.name_en
    card_name = card.name_en.gsub('é','e').gsub('α','Alfa').gsub('β','Beta')
                            .gsub('γ','Gamma').gsub('& ','')
                            .gsub('♂',' Male').gsub('♀',' Female')

    if expansion_name == "Delta Species"
      card_name = card_name.gsub('δ','D').tr("^A-Za-z0-9-. ", '').strip
    else
      card_name = card_name.gsub('δ','Delta').tr("^A-Za-z0-9-. ", '').strip
    end

    card_prefix = card.expansion.prefix
    card_number = card.number.split('/')[0]
    if ['Gym','Neo','XY','Generations'].include? expansion_name
      card_link = "#{card_name} #{expansion_name} ".downcase + card_number.upcase
    elsif expansion_name.include?('Furious Fists')
      card_link = "#{card_name} #{expansion_name} frf #{card_number}".downcase
    elsif expansion_name.include?('Primal Clash')
      card_link = "#{card_name} #{expansion_name} pcl #{card_number}".downcase
    else
      card_link = "#{card_name} #{expansion_name} #{card_prefix} #{card_number}".downcase
    end
    card_link = card_link.gsub(' ', '-')
    url = "http://pkmncards.com/wp-content/uploads/#{card_link}.jpg"
    url2 = "http://pkmncards.com/wp-content/uploads/#{card_link}-ptcgo-1.png"
    agent = Mechanize.new
    begin
      agent.get(url)
      card.update(photo: url)
      new_img+=1
    rescue
      begin
        agent.get(url2)
        card.update(photo: url2)
      rescue
        p "Não encontrado! #{card_link}"
        not_found+=1
      end
    end
  end
  p "Novos: #{new_img} Não encontrados: #{not_found}"
end
