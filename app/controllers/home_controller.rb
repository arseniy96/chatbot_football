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
    response = JSON.parse(response.body).first
    if response['access_token']
      user = User.find_by(uid: user_id.to_s)
      if user
        @user = user
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

        @user = User.create(uid: user_id.to_i,
                            provider: 'vkontakte',
                            firstname: user_params['first_name'],
                            lastname: user_params['last_name'],
                            avatar: avatar_img,
                            code: user_code,
                            email: user_id.to_s + user_code + '@vk.com',
                            password: password,
                            password_confirmation: password)
      end
      # @user = Services::CreateUser.call(response['user_id'])
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Vkontakte"
      sign_in_and_redirect root_path, event: :authentication
    else
      flash[:notice] = 'Ошибка'
      redirect_to root_path
    end
  end

end
