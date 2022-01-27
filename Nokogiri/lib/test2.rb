require 'nokogiri'  
require 'open-uri' 

#stocker des emails en fonction d'une URL variable
def get_townhall_email(example)
    page = Nokogiri::HTML(URI.open(example))

    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    return email
                  
end

#trouver les URLs des mairies du Val d'Oise (pour les associer par la suite à la méthode du dessus)
def get_townhall_urls
    page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))

    #trouver toutes les URLS au format ./95/bezons.html
    urls = page.xpath('//a[@class="lientxt"]/@href').map{|x| x.text[1..-1]}

    #nombre d'URL trouvé * l'URL du site + ./95/bezons.html 
    urls.length.times do |url|
    urls[url] = "https://www.annuaire-des-mairies.com" + urls[url] 
    end 
    
    return urls
end

#trouver le nom des mairies en fonction de la page Val d'Oise
def get_townhall_names
    page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
    town_names = page.xpath('//a[@class="lientxt"]').map{|x| x.text}
    return town_names
end

#trouver les emails du Val d'Oise en fonction des URLs trouvées dans la méthode get_townhell_urls
def array_emails
     urls = get_townhall_urls
    

    emails = urls.map{|url| get_townhall_email(url)}
 return emails

end


#on rassemble emails et names dans plusieurs hashes dans un array
def perform
   names = get_townhall_names
   emails = array_emails 
    list = names.zip(emails).each_slice(1).map(&:to_h)
    puts list
end

 puts perform
