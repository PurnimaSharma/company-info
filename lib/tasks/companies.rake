desc "Companies information from yellow pages"

namespace :companies do
  task :parser => :environment do
      require 'nokogiri'
      require 'open-uri'
      count = 0
      states = State.all
      states.each do |state|  	
	    search_term = 'busiiness'
	    url = "http://www.yellowpages.com/search?search_terms=#{search_term}&geo_location_terms=#{state.name}"
		doc = Nokogiri::HTML(open(url))
	    string = doc.css('.pagination').text.split.last
	    string = string[0...string.index("results")]
	    pages = 1..(string.to_d / 30.to_d).ceil
	    pages .each do |page|	
	    	master_url = url + "&page=#{page}"
	    	doc = Nokogiri::HTML(open(master_url))
		    results = doc.css(".search-results").css('.result').css('.media-thumbnail')
		    results.each do |result|
		      href = result.children[0].attributes["href"].to_s
		      yellowpage_id = href.split('lid=')[1]
              company = Company.find_by(yellowpage_id: yellowpage_id)
              unless company.present?
			      master_url = "http://www.yellowpages.com#{href}"
			      doc = Nokogiri::HTML(open(master_url))
			      name = doc.css('.sales-info').text
			      address = doc.css('.contact').text
			      phone_no = doc.css('.phone').text
			      email = doc.css('.email-business')[0]
			      email = email.attributes["href"].to_s.gsub('mailto:', '') if email.present?
			      state.companies.create(name: name, contact_no: phone_no, email: email, address: address, yellowpage_id: yellowpage_id )
			      puts name
			      count = count + 1
			      puts count
			      if count == 20000
			      	abort '20000 companies created'
			      end
			   end
		    end
	    end
	end
  end
end
