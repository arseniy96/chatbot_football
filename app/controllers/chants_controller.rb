class ChantsController < ApplicationController

  before_action :authenticate_user!, only: [:create]
  before_action :authenticate_admin!, only: [:index]

  def index

  end

  def show
    @chant = Chant.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @chant = Services::CreateChant.call(current_user)
    redirect_to @chant
  end

end
