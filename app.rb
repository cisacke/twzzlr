require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'dotenv'
Dotenv.load

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['ACCESS_KEY'],
    :aws_secret_access_key  => ENV['SECRET_ACCESS_KEY'],
    :region                 => 'us-east-1'
  }
  config.fog_directory  = ENV['BUCKET_NAME']
  config.fog_public = true
end

class MyUploader < CarrierWave::Uploader::Base
  storage :fog
end

class Image < ActiveRecord::Base
    mount_uploader :image, MyUploader
end

class Twzzlr < Sinatra::Base
    get '/' do
        @twzzlz = Image.all
        erb :'twzzlz/index'
    end
    
    post '/' do
        twzzl = Image.new
        puts params[:image]
        twzzl.image = params[:image]
        twzzl.save
        redirect to('/')
    end
end