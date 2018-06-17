class ChantsController < ApplicationController

  def index

  end

  def show
    @chant = Chant.find(params[:id])
  end

  def create
    @chant = Services::CreateChant.call(params[:chant][:user_id])
    redirect_to @chant
  end

end
