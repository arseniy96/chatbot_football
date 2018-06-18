class User < ApplicationRecord
  has_many :chants

  mount_uploader :avatar, PosterUploader
end
