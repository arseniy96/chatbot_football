module Services
  class GetPosts
    require 'net/http'
    require 'uri'

    def self.call(user_id, token)
      params = "owner_id=#{user_id}&count=10&access_token=#{token}&v=5.78&lang=ru"
      url = 'https://api.vk.com/method/wall.get?' + params
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
      posts = JSON.parse(response.body)['response']['items']
      posts_str = ""
      posts.each do |post|
        attachment_type = post['attachments'] ? post['attachments'].first['type'] : ''
        posts_str += '#%#text=' + post['text'] + '#%#attachment_type=' + attachment_type + '%%'
      end
      return posts_str
    end

  end
end