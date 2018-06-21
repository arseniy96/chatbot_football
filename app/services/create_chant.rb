module Services
  class CreateChant

    def self.call(user, chant_params)
      img = Magick::Image.read(Rails.root + 'public/test.jpg').first
      copyright = Magick::Draw.new
      copyright.annotate(img, 0, 0, 100, 280, user.firstname) do
        self.font = 'Georgia'
        self.pointsize = 24
        self.font_weight = Magick::BoldWeight
        self.fill = 'white'
        self.gravity = Magick::SouthEastGravity
      end
      img_name = (Time.now.to_i + user.id.to_i).to_s
      img.write(Rails.root + "public/#{img_name}.jpg")
      chant_image = File.open(Rails.root + "public/#{img_name}.jpg")
      user.chants.create(text: 'Blah', image: chant_image, country1: chant_params[:country1], country2: chant_params[:country2])
    end

  end
end