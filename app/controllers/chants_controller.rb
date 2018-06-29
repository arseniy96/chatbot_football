class ChantsController < ApplicationController

  before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!, only: [:new, :create]

  def index

  end

  def show
    @user = User.find(params[:user_id])
    @chant = Chant.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    if params[:user_id].to_i != current_user.id
      redirect_to new_user_chant_path(current_user)
    end
    @chant = Chant.new
    @countries = {'Австралия': 'aust', 'Англия': 'eng', 'Аргентина': 'arg', 'Бельгия': 'belg', 'Бразилия': 'bra', 'Германия': 'ger', 'Дания': 'dan', 'Египет': 'egy', 'Испания': 'spain', 'Иран': 'iran', 'Колумбия': 'col', 'Коста-Рика': 'kosta', 'Марокко': 'marok', 'Мексика': 'mex', 'Нигерия': 'nig', 'Панама': 'pan', 'Перу': 'peru', 'Польша': 'pol', 'Португалия': 'port', 'Россия': 'ru', 'Саудовская Аравия' => 'saudi', 'Сербия': 'serb', 'Синегал': 'sineg', 'Тунис': 'tun', 'Швейцария': 'switz', 'Швеция': 'swe', 'Уругвай': 'urug', 'Франция': 'fra', 'Хорватия': 'horv', 'Южная Корея': 'korea', 'Япония': 'jap'}
  end

  def create
    if user_signed_in?
      chant_params = params.require(:chant).permit!.to_h
      @chant = Services::CreateChant.call(current_user, chant_params)
      redirect_to user_chant_path(current_user, @chant)
    else
      redirect_to 'https://oauth.vk.com/authorize?client_id=6609013&display=popup&redirect_uri=https%3A%2F%2Ffootball-chatbot.herokuapp.com%2Fcallback&response_type=code&scope=friends%2Cphotos%2Cgroups&v=5.80'
    end
  end

end
