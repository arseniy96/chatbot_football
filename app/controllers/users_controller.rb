class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @users = User.order('rating')
  end

  def show
    @user = User.find(params[:id])
  end

  def change_rating
    @user = User.find(params[:id])
    rating = @user.rating.is_a?(Integer) ? @user.rating + 1 : 1
    @user.update_attributes(rating: rating)
    render json: 'success', status: 200
  end

end
