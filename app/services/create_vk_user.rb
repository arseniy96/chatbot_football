module Services
  class CreateVkUser

    def self.call(access_token)
      if User.where(uid: access_token.uid).first
        user
      else
        user_code = Faker::Internet.password(6, 10)
        password = Devise.friendly_token[0, 20]

        # params = "user_ids=#{access_token.uid}&fields=photo_200&access_token=2f764c762f764c762f764c768b2f2a4fcf22f762f764c76766152af8b40b791c12b1de6&v=5.78"
        # url = 'https://api.vk.com/method/users.get?' + params
        # uri = URI.parse(url)
        # http = Net::HTTP.new(uri.host, uri.port)
        # http.use_ssl = true
        # response = http.request(Net::HTTP::Get.new(uri.request_uri))
        # user_params = JSON.parse(response.body)['response'].first
        # im = Magick::Image.read(user_params['photo_200']).first
        im = Magick::Image.read(access_token.info.image).first
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

        User.create!(uid: access_token.uid,
                     provider: access_token.provider,
                     firstname: access_token.info.first_name,
                     lastname: access_token.info.last_name,
                     email: access_token.uid + access_token.user_code + '@vk.com',
                     password: password,
                     password_confirmation: password,
                     avatar: avatar_img,
                     code: user_code)
      end
    end

  end
end