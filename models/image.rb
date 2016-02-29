require 'carrierwave'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIFA7KDFM6M26NKXA',
    :aws_secret_access_key  => 'ZH9Wt7SUGFCQHxXfpsOTmPThUZccm7bvUib1t4'
  }
  config.fog_directory  = 'twzzlr-dev'
end

class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end

class Image < ActiveRecord::Base
    mount_uploader :file, MyUploader
end