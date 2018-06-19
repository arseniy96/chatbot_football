class HomeController < ApplicationController
  # before_action :authenticate_admin!

  def index
    # img = Magick::Image.read(Rails.root + 'public/test.jpg').first
    # my_text = "Какая-то кричалка"
    #
    # copyright = Magick::Draw.new
    # copyright.annotate(img, 0, 0, 100, 280, my_text) do
    #   self.font = 'Georgia'
    #   self.pointsize = 24
    #   self.font_weight = Magick::BoldWeight
    #   self.fill = 'white'
    #   self.gravity = Magick::SouthEastGravity
    # end
    # img.write(Rails.root + 'public/testcopyrighted.jpg')
  end

  def callback
    redirect_to "https://oauth.vk.com/access_token?client_id=6609013&client_secret=7Pgv4022yLWmYlOzR0Ph&redirect_uri=https%3A%2F%2Ffootball-chatbot.herokuapp.com%2Fcallback&code=#{params[:code]}"
  end

end
