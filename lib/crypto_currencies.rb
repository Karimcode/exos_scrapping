require 'nokogiri'
require 'open-uri'



def crypto_scrapper

    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

    currencies = []
    page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr["crypto"]/td[2]/div/a').each do |crypto|
        currencies << crypto.text
    end

    values = []
    page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr["value"]/td[5]/a').each do |value|
        values << value.text
    end

    hash = currencies.zip(values).to_h
end

puts crypto_scrapper


