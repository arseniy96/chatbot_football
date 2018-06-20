class User < ApplicationRecord
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte]
  has_many :chants

  mount_uploader :avatar, PosterUploader

  def full_name
    "#{firstname} #{lastname}"
  end

end
