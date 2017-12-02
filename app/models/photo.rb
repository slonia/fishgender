class Photo < ApplicationRecord
  include Usable

  mount_uploader :image, ImageUploader
end
