require 'nokogiri'
require 'open-uri'


# récupère l’e-mail d'une mairie à partir de l'URL de mairies

def get_townhall_email(townhall_url)

    email = []
    page = Nokogiri::HTML(open(townhall_url))
    page.xpath('//td[contains(text(), "@")]').each do |adresse|
        email.push(adresse.text)
    end
    return email
end



# Récupère les URLs de chaque ville du 95

def get_townhall_urls


    # Récupère la liste des noms des villes du 95
    town_name = []
    name_town = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    name_town.xpath('//a[contains(@href, "95")]').each do |ville|
        town_name.push(ville.text)
    end
    # return puts town_name


    # Récupère la liste des urls des villes du 95
    town_url = []
    name_town = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    name_town.xpath('//a[contains(@href, "95")]/@href').each do |ville|
        town_url.push(ville.text)
    end
    # return puts town_url

    # Retourne l'url de chacune des villes
    email_array = []
    town_url.each do |end_url|
      end_url = end_url[1..-1]
      final_url = "https://www.annuaire-des-mairies.com" + end_url
      email_array.push(get_townhall_email(final_url))
    end
    # Hash
    final_hash = town_name.zip(email_array).to_h

    puts final_hash

end


get_townhall_urls
