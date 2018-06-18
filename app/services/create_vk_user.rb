module Services
  class CreateVkUser

    def self.call(access_token)
      if User.where(uid: access_token.uid).first
        user
      else
        user_code = Faker::Internet.password(6, 10)
        password = Devise.friendly_token[0, 20]

        im = Magick::Image.read(user_params['photo_200']).first
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