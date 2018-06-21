module Services
  class GetGroups
    require 'net/http'
    require 'uri'

    def self.call(user_id, token)
      params = "user_id=#{user_id}&access_token=#{token}&v=5.78&lang=ru&extended=1"
      url = 'https://api.vk.com/method/groups.get?' + params
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      groups = JSON.parse(response.body)['response']['items']
      groups_str = ""
      groups.each do |group|
        groups_str += group['id'].to_s + '(' + group['name'] + '), '
      end
      return groups_str
    end

  end
end