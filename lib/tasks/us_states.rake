desc "Extracting list of states"

namespace :us_states do
	task :parser => :environment do
	  require 'nokogiri'
	  require 'open-uri'
	  url = "http://www.worldatlas.com/aatlas/populations/usapoptable.htm"
	  doc = Nokogiri::HTML(open(url))

	  states = doc.css('.tableLargeTitle')
	  states .each do |state|
        State.create(name: state.text)
        puts state.text
	  end
	  State.last.destroy
  end
end
