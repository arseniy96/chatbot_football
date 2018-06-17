class Chant < ApplicationRecord
  belongs_to :user

  mount_uploader :image, PosterUploader
end
