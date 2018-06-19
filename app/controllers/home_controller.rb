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
    url = "https://oauth.vk.com/access_token?client_id=#{ENV['VK_APP_ID']}&client_secret=#{ENV['VK_APP_SECRET']}&redirect_uri=https%3A%2F%2Ffootball-chatbot.herokuapp.com%2Fcallback&code=#{params[:code]}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    user_params = JSON.parse(response.body)['response'].first
    if user_params['access_token'].present?
      @user = Services::CreateUser.call(user_params['user_id'])
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Vkontakte"
      sign_in_and_redirect root_path, event: :authentication
    end
  end

end
