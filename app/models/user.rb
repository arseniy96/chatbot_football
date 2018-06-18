class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte]
  has_many :chants

  mount_uploader :avatar, PosterUploader

  def self.find_for_vkontakte_oauth access_token
    Services::CreateVkUser.call(access_token)
  end

end
