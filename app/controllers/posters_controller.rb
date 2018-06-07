class PostersController < ApplicationController

  def index

  end

  def show
    @poster = Poster.find(params[:id])
  end

  def create
    username = params[:poster][:username]
    user_id = Poster.count
    img = Magick::Image.read(Rails.root + 'public/test.jpg').first

    copyright = Magick::Draw.new
    copyright.annotate(img, 0, 0, 100, 280, username) do
      self.font = 'Georgia'
      self.pointsize = 24
      self.font_weight = Magick::BoldWeight
      self.fill = 'white'
      self.gravity = Magick::SouthEastGravity
    end
    img.write(Rails.root + "public/test#{user_id}.jpg")
    poster_image = File.open(Rails.root + "public/test#{user_id}.jpg")
    @poster = Poster.create(user_id: user_id, username: username, image: poster_image)
    redirect_to @poster
  end

end
