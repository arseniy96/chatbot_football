module Services
  class CreateChant

    def self.call(user, chant_params)
      country1 = chant_params[:country1]
      country2 = chant_params[:country2]
      chant_text = GenerateTextForChant.call(user.firstname)
      # main image
      img = Magick::Image.read(Rails.root + 'public/images/chant-w.jpg').first
      # download avatar and save to local file
      if Rails.env == 'production'
        avatar_tmp = open(user.avatar.url)
        IO.copy_stream(avatar_tmp, Rails.root + 'public/chant_avatar_tmp.jpg')
        avatar = Magick::Image.read(Rails.root + 'public/chant_avatar_tmp.jpg').first
      else
        avatar = Magick::Image.read(Rails.root + 'public/avatar28test.png').first
      end
      avatar.resize_to_fit!(115, 115)
      # first country image
      fcountry = Magick::Image.read(Rails.root + "public/images/country/#{country1}.png").first
      fcountry.resize!(120, 90)
      # second country image
      scountry = Magick::Image.read(Rails.root + "public/images/country/#{country2}.png").first
      scountry.resize!(120, 90)

      img.composite!(avatar, 1567, 510, Magick::OverCompositeOp)
      img.composite!(fcountry, 15, 630, Magick::OverCompositeOp)
      img.composite!(scountry, 130, 630, Magick::OverCompositeOp)

      copyright = Magick::Draw.new
      copyright.annotate(img, 0, 0, 570, 370, chant_text) do
        self.font = "#{Rails.root}/public/fonts/HelveticaNeueCyr.ttf"
        self.pointsize = 48
        self.font_weight = Magick::BoldWeight
        self.fill = '#E03EDE'
        self.gravity = Magick::SouthWestGravity
      end

      img_name = (Time.now.to_i + user.id.to_i).to_s
      img.write(Rails.root + "public/#{img_name}.jpg")
      chant_image = File.open(Rails.root + "public/#{img_name}.jpg")

      user.chants.create(text: chant_text, image: chant_image, country1: country1, country2: country2)
    end

  end
end