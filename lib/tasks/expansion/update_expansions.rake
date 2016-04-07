# desc "Update Expansions"
# task update_expansions: :environment do
#   require 'nokogiri'
#   require 'mechanize'
#   url = "http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_Trading_Card_Game_expansions"
#   agent = Mechanize.new
#   agent.get(url)a
#   doc = agent.page
#   doc.css("tr").each do |item|
#       link = item.at_css("td:nth-child(4) a")
#       # icon = item.at_css("td:nth-child(3) img")
#       unless link.nil?
#         expansion_link = "http://bulbapedia.bulbagarden.net#{link[:href]}"
#         name = link.text
#         # icon = icon[:src]
#       end
#   expansion = Expansion.find_by_name_en(name) ||
#   Expansion.create(name_en: name, expansion_link: expansion_link) unless name.nil?
#   end
#
#   # url = "http://www.serebii.net/card/english.shtml"
#   # doc =  Nokogiri::HTML(open(url))
#   # doc.css("tr .cen").each do |item|
#   #   puts "#{item.at_css("td")} teste"
#   # end
#
# end
