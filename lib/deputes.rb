require 'nokogiri'
require 'open-uri'
require 'pry'


# récupère l’e-mail d'un député à partir de l'url

def get_depute_email(depute_url)

    email = ""
    page = Nokogiri::HTML(open(depute_url))
    page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').each do |adresse|
        email+= adresse.text
    end
    return  email
end

def get_depute_first_name(depute_url)

    email = ""
    page = Nokogiri::HTML(open(depute_url))
    page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').each do |adresse|
        email+= adresse.text
    end

        depute_array = email.split(/\W+/)
        depute_array.pop
        depute_array.pop
        depute_array.pop
        depute_array.pop
        string = depute_array.join('-')


        return string.capitalize

    # return depute_array

    # return  email
end


def get_depute_last_name(depute_url)

    email = ""
    page = Nokogiri::HTML(open(depute_url))
    page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').each do |adresse|
        email+= adresse.text
    end

        depute_array = email.split(/\W+/).to_a
        depute_array.pop
        depute_array.pop
        depute_array.pop
        depute_array.shift
        string = depute_array.join('-')

        # depute_array = depute_array_temp2.delete_at(2)
    # end
    return string.capitalize

    # return  email
end



# Récupère les URLs de chaque député

def get_depute_urls


    # Récupère la liste des noms des députés
    # depute_name = []
    # words = []

    # name_depute = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    # name_depute.xpath('//a[contains(@href, "fiche")]').each do |people|
    #     depute_name.push(people.text)
    # end
     # puts depute_name.map


    # Récupère la liste des urls des députés

    depute_url = []

    name_depute = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    name_depute.xpath('//a[contains(@href, "fiche")]/@href').each do |people|
        depute_url.push(people.text)
    end
    # return puts depute_url

    # Retourne l'url de chacune des villes
    # Retourne l'url de chacuns des députés

    first_name_array = []
    last_name_array = []
    email_array = []
    final_array = []
    depute_url.each do |end_url|
      # end_url = end_url[1..-1]
      final_url = "http://www2.assemblee-nationale.fr" + end_url
      first_name_array.push(get_depute_first_name(final_url))
      last_name_array.push(get_depute_last_name(final_url))
      email_array.push(get_depute_email(final_url))
      end

      a = depute_url.length
      for i in 0..a do
     depute_hash = {
      :first_name => first_name_array[i],
      :last_name => last_name_array[i],
      :email => email_array[i] }
      final_array.push(depute_hash)
            binding.pry
    end
      # final_hash.each {|key, value| puts "#{key} is #{value}" }
       # binding.pry

     #   final_array.push(depute_hash)
     #  puts final_array
     # # end

    end





    # Hash
     # final_hash = name_array.zip(email_array).to_h
    #  tab_test_a = ["prénom", "nom"]
    #  tab_test_b = ["adresse_email"]

    #  final_hash = {
    #   :first_name => name_array[0],
    #   :last_name => name_array[1],
    #   :email => email_array[0] }
    #  binding.pry
    # puts final_hash



get_depute_urls
