require 'carrierwave'
require 'carrierwave/orm/activerecord'

class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end

class Image < ActiveRecord::Base
    mount_uploader :image, MyUploader
    has_many :unwraps, dependent: :destroy
    belongs_to :user
end