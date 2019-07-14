require 'net/http'
require 'json'
require 'uri'

class Idmws

	def self.getCardNumber(duke_unique_id)
		url = "https://idms-web-ws.oit.duke.edu/idm-ws/user/findById/#{duke_unique_id}?attributes=USR_UDF_DUKECARDNBR"
		uri = URI.parse(url)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		request.basic_auth(ENV["IDMS_USER"], ENV["IDMS_PASSWORD"])
		response = http.request(request).body
		doc = JSON.parse(response)
		dukecardnumber = doc["userQueryResult"]["users"][0]["attributes"]["USR_UDF_DUKECARDNBR"]

		dukecardnumber #return
	end

	#id can be either a dukeuniqueid or a dukecardnumber
	#idtype must specify "duid" or "card"
	def self.getName(id, idtype)
		if idtype == "duid"
			url = "https://idms-web-ws.oit.duke.edu/idm-ws/user/findById/#{id}?attributes=USR_FIRST_NAME,USR_LAST_NAME" #USR_FIRST_NAME
		end
		if idtype == "card"
			url = "https://idms-web-ws.oit.duke.edu/idm-ws/user/findByIdentifier?identifierAttribute=USR_UDF_DUKECARDNBR&identifier=#{id}&attributes=USR_FIRST_NAME,USR_LAST_NAME" #USR_FIRST_NAME
		end
		uri = URI.parse(url)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		request.basic_auth(ENV["IDMS_USER"], ENV["IDMS_PASSWORD"])
		response = http.request(request).body
		doc = JSON.parse(response)
		username = doc["userQueryResult"]["users"][0]["attributes"]["USR_FIRST_NAME"][0] + " " + doc["userQueryResult"]["users"][0]["attributes"]["USR_LAST_NAME"][0]

		username #return
	end


end