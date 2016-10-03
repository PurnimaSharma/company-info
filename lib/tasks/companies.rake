desc "Companies information from yellow pages"

namespace :companies do
  task :parser => :environment do
      require 'nokogiri'
      require 'open-uri'
    search_term = 'busiiness'
    location_term = 'United States'
    url = "http://www.yellowpages.com/search?search_terms=#{search_term}&geo_location_terms=#{location_term}"
	doc = Nokogiri::HTML(open(url))
    string = doc.css('.pagination').text.split.last
    string = string[0...string.index("results")]
    pages = 1..(string.to_d / 30.to_d).ceil
    pages .each do |page|
    	url = url + "&page=#{page}"
    	doc = Nokogiri::HTML(open(url))
	    results = doc.css(".search-results").css('.result').css('.media-thumbnail')
	    results.each do |result|
	      href = result.children[0].attributes["href"].to_s
	      master_url = "http://www.yellowpages.com#{href}"
	      doc = Nokogiri::HTML(open(master_url))
	      name = doc.css('.sales-info').text
	      address = doc.css('.contact').text
	      phone_no = doc.css('.phone').text
	      email = doc.css('.email-business')[0]
	      email = email.attributes["href"].to_s.gsub('mailto:', '') if email.present?
	      Company.create(name: name, contact_no: phone_no, email: email)
	      puts name
	    end
    end
  end
end
