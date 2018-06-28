class HomeController < ApplicationController
  # before_action :authenticate_admin!

  def index
    # unless user_signed_in?
    #   @user = Services::CreateUser.call(28833104, 'aa@bb.com', 'ab99173579e1ef34aa089605bdb5d07a5078ecbac4b69ba4db6e1d0196e655b0657bd34dfb9da23ff80f1')
    #   sign_in_and_redirect @user, event: :authentication
    # end
    @chants = Chant.order('created_at DESC')
    @best_users = User.order('rating').limit(10)
    @new_users = User.order('created_at DESC').limit(8)
  end

  def callback
    url = "https://oauth.vk.com/access_token?client_id=#{ENV['VK_APP_ID']}&client_secret=#{ENV['VK_APP_SECRET']}&redirect_uri=https%3A%2F%2Ffootball-chatbot.herokuapp.com%2Fcallback&code=#{params[:code]}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    response = JSON.parse(response.body)
    if response['access_token']
      @user = Services::CreateUser.call(response['user_id'], response['email'], response['access_token'])
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Vkontakte"
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = 'Ошибка'
      redirect_to root_path
    end
  end

end
