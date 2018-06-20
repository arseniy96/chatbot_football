class ChantsController < ApplicationController

  before_action :authenticate_admin!, only: [:index]

  def index

  end

  def show
    @chant = Chant.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    if user_signed_in?
      @chant = Services::CreateChant.call(current_user)
      redirect_to user_chant_path(current_user, @chant)
    else
      redirect_to 'https://oauth.vk.com/authorize?client_id=6609013&display=popup&redirect_uri=https%3A%2F%2Ffootball-chatbot.herokuapp.com%2Fcallback&response_type=code&scope=friends%2Cphotos%2Cgroups&v=5.80'
    end
  end

end
