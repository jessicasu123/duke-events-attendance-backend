require 'net/http'
require 'uri'
require 'nokogiri'

class Transact
	def self.verify(dukecard_xml)

		#BOUNDARY = "AaB03x"

		#url = "https://dcobroker.oit.duke.edu/"

		url = ENV["TRANSACT_URL"]
		#puts "url : #{url}"
		uri = URI.parse(url)
		#file = File.open('example.xml')
		#puts "xml from file: #{File.read(file)}"
		#puts "xml from function: #{dukecard_xml}"

		post_body = []
		post_body << "--AaB03xrn"
		post_body << "Content-Disposition: form-data; name='datafile'; filename="#{File.basename(file)}"rn"
		post_body << "Content-Type: text/plainrn"
		post_body << "rn"
		post_body << dukecard_xml
		#post_body << File.read(file) 
		post_body << "rn--AaB03x--rn"

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Post.new(uri.request_uri)
		request.body = post_body.join

		request["Content-Type"] = "multipart/form-data, boundary=AaB03x"

		response = http.request(request).body
		doc = Nokogiri::XML(response)

		status = doc.xpath("//status_code").inner_text
		info = doc.xpath("//status_text").inner_text

		puts "Status: " + status
		puts "Description: " + info

		status
	end
end
