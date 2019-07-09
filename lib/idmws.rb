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
		request.basic_auth("eventsattendance", "ieiA@GgtQVT+@*1KGRSDS3y+")
		response = http.request(request).body
		doc = JSON.parse(response)
		dukecardnumber = doc["userQueryResult"]["users"][0]["attributes"]["USR_UDF_DUKECARDNBR"]

		dukecardnumber #return
	end

end