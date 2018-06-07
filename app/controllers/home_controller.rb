class HomeController < ApplicationController

  def index
    img = Magick::Image.read(Rails.root + 'public/test.jpg').first
    my_text = "Какая-то кричалка"

    copyright = Magick::Draw.new
    copyright.annotate(img, 0, 0, 100, 280, my_text) do
      self.font = 'Georgia'
      self.pointsize = 24
      self.font_weight = Magick::BoldWeight
      self.fill = 'white'
      self.gravity = Magick::SouthEastGravity
    end
    img.write('testcopyrighted.jpg')
  end

end
