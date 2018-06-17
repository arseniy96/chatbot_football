module Services
  class CreateUser
    require 'net/http'
    require 'uri'

    def self.call(user_id)
      user = User.find_by(vk_id: user_id)
      if user
        return user
      else
        params = "user_ids=#{user_id}&fields=bdate,photo_200&access_token=2f764c762f764c762f764c768b2f2a4fcf22f762f764c76766152af8b40b791c12b1de6&v=5.78"
        url = 'https://api.vk.com/method/users.get?' + params
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.request(Net::HTTP::Get.new(uri.request_uri))
        user_params = JSON.parse(response.body)['response'].first
        user_code = Faker::Internet.password(6, 10)
        User.create(vk_id: user_params['id'], firstname: user_params['first_name'], lastname: user_params['last_name'], avatar: user_params['photo_200'], code: user_code)
      end
    end

  end
end