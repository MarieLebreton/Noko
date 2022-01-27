require 'nokogiri'  
require 'open-uri' 

def new_hash

  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   
  # => Nokogiri::HTML::Document

  #construction d'arrays dans le but de les réunir en hash
  name = Array.new
  value = Array.new



  #on trouve les noms des cryptos avec le xpath et les ajoutent au array name 
  page.xpath('//html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[*]/td[3]/div').each do |x| name << x.text
  end

  #on trouve les values des cryptos avec le xpath et les ajoutent au array value
  page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[*]/td[5]/div/a/span'). each do |y|
    value << y.text
  end

 #on rassemble nom de la crypto et la valeur
  new_hash = name.zip(value).to_h
 
  

end

puts new_hash

#test taille hash
def hash_length
  return new_hash.length
end

#test value hash
def hash_check
  return new_hash.has_key?("BTC")
end

