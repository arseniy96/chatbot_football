module Services
  class CreateUser
    require 'net/http'
    require 'uri'
    require 'open-uri'

    def self.call(user_id)
      user = User.find_by(uid: user_id.to_s)
      if user
        return user
      else
        user_code = Faker::Internet.password(6, 10)
        password = Devise.friendly_token[0, 20]

        params = "user_ids=#{user_id}&fields=bdate,photo_200&access_token=2f764c762f764c762f764c768b2f2a4fcf22f762f764c76766152af8b40b791c12b1de6&v=5.78"
        url = 'https://api.vk.com/method/users.get?' + params
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.request(Net::HTTP::Get.new(uri.request_uri))
        user_params = JSON.parse(response.body)['response'].first

        avatar_tmp = open(user_params['photo_200'])
        IO.copy_stream(avatar_tmp, Rails.root + 'public/avatar_tmp.jpg')
        im = Magick::Image.read(Rails.root + 'public/avatar_tmp.jpg').first
        circle = Magick::Image.new 200, 200
        gc = Magick::Draw.new
        gc.fill 'black'
        gc.circle 100, 100, 100, 1
        gc.draw circle
        mask = circle.blur_image(0, 1).negate
        mask.matte = false
        im.matte = true
        im.composite!(mask, Magick::CenterGravity, Magick::CopyOpacityCompositeOp)
        img_name = 'avatar' + user_id.to_s
        im.write(Rails.root + "public/#{img_name}.png")
        avatar_img = File.open(Rails.root + "public/#{img_name}.png")

        User.create(uid: user_id.to_i,
                    provider: 'vkontakte',
                    firstname: user_params['first_name'],
                    lastname: user_params['last_name'],
                    avatar: avatar_img,
                    code: user_code,
                    email: user_id.to_s + user_code + '@vk.com',
                    password: password,
                    password_confirmation: password)
      end
    end

  end
end